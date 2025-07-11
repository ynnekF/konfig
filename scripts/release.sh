#!/bin/bash

NC='\033[0m'

if command -v which >/dev/null 2>&1; then
	GIT="$(which git)"
else
	GIT="$(command -v git)"
fi

declare -a messages
declare -a commits
declare -a blobs

function error() {
	local code=${2:-1} # default exit code 1
	echo "Error: $1" >&2
	exit "$code"
}

while :; do
	case "${1:-}" in
		--from)
			FROM_TAG="${2-}"
			shift
			;;
		--to)
			TO_TAG="${2-}"
			shift
			;;
		--help)
			echo "Usage: $0 --from <tag> --to <tag>"
			exit 0
			;;
		-?*)
			error "Invalid command-line arguments"
			;;
		*) break ;;
	esac
	shift
done

# Compute which revisions of MDM we want to search.
# Need to specify a beginning and an end commit history.
if [[ -z $FROM_TAG ]]; then
	echo "No 'from' tag given, defaulting to the most recent tag created."

	FROM_TAG=$($GIT describe --tags --abbrev=0)

	if [[ -z $FROM_TAG ]]; then
		error "Unable to find 'from' tag"
	fi
fi

if [[ -z "$TO_TAG" ]]; then
	echo "No 'to' tag given, defaulting to HEAD"
	TO_TAG="HEAD"
fi

printf "\nComputing \033[0;31m%s$NC --> \033[0;32m%s$NC\n\n" "$FROM_TAG" "$TO_TAG"

# Get the commit hash associated with the tag provided
# within the 'from' tag so we can search for commits.
REV=$($GIT rev-list -n 1 "$FROM_TAG")
[[ -z $REV ]] && error "no revisions"

# Access all commits from the commit hash of the FROM_TAG
# to the endpoint point (typically HEAD unless provided).
# Use "first-parent" to get a mainline history ignoring
# side branches. Need a linear history.
while IFS= read -r var; do
	commits+=("$var")
done < <($GIT rev-list --first-parent "$REV".."$TO_TAG")
[[ ${#commits[@]} -eq 0 ]] && error "No commits found between $FROM_TAG and $TO_TAG."

# Use git-show to access the related commit information
# and retrieve only the necessary details from the data.
for commit in "${commits[@]}"; do
	revision=$(git --no-pager show -w -s --abbrev-commit "$commit" | awk NF |
		grep -Ev "See merge request|Merge Branch|Closes" |
		sed s/"commit"// |
		sed s/"Merge:"// |
		sed s/"Author:"// |
		sed s/"Date:"//)

  tag=$(GIT describe --contains --all "$commit")
	revision+=" $tag"

	revision=$(echo "$revision" | tr -d '\t\n')
	blobs+=("$revision")
done

# shellcheck disable=SC2178
messages=$(printf "SHA1\tSHA2\tSHA3\tNAME\tDate\tBranches\tTag\tMessage")
for detail in "${blobs[@]}"; do
	cleaned=$(echo "$detail" | awk '
  {
  sha1 = $1
  sha2 = $2
  sha3 = $3
  # find email index
  email = ""
  for (i = 4; i <= NF; i++) {
    if ($i ~ /^<[^>]+>$/) {
      email = $i
      email_idx = i
      break
    }
  }
  # join name fields
  name = $4
  for (i = 5; i < email_idx; i++) {
    name = name " " $i
  }
  # find timezone
  tz_idx = 0
  for (i = email_idx + 1; i <= NF; i++) {
    if ($i ~ /^\+[0-9]{4}$/) {
      tz_idx = i
      break
    }
  }
  # join date fields
  date_str = $(email_idx + 1)
  for (i = email_idx + 2; i <= tz_idx; i++) {
    date_str = date_str " " $i
  }
  # Format date using macOS `date -j -f` approach
  fmt = "%A %B %d %H:%M:%S %Y +0000"
  cmd = "date -j -f \"" fmt "\" \"" date_str "\" +\"%m/%d/%y\""
  cmd | getline formatted_date
  close(cmd)

  # join remaining as message
  message = $(tz_idx + 1)
  for (i = tz_idx + 2; i <= NF; i++) {
    if (i == NF) {
      tag = $i
    } else {
      message = message " " $i
    }
  }


  branch1 = ""; branch2 = ""; extra = ""
  split(message, parts, " ")

  gsub(/^<|>$/, "", email)  # remove < >

  # Check for "Merge branch <branch1> into <branch2> ..."
  branch1 = ""; branch2 = ""; extra = ""
  split(message, parts, " ")
  if (parts[1] == "Merge" && parts[2] == "branch" && parts[4] == "into") {
    branch1 = parts[3]
    branch2 = parts[5]
    for (x = 6; x <= length(parts); x++) {
      extra = extra (x == 6 ? "" : " ") parts[x]
    }
  }

  # Print tab-separated values, and the parsed branches if applicable (EMAIL REMOVED)
  printf "%s\t%s\t%s\t%s\t%s\t%s -> %s\t[%s]\t%s\n", sha1, sha2, sha3, name, formatted_date, branch1, branch2, tag, extra
  }
  ')
	messages+=("$cleaned")
done

{
	for message in "${messages[@]}"; do
		echo "$message"
	done
} | column -t -s $'\t'