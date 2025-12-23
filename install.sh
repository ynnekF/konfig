#!/bin/bash
#
# Install files from repository to their respective paths
#
declare -- VERSION="1.0.0"

IFS=$'\n\t'

# Exit immediately on any non-zero status
set -e

# Exit on unset variables
set -u

# Crash pipeline
set -o pipefail

OS_TYPE=$(uname -s)
case "$OS_TYPE" in
	Linux | Darwin)
		# Supported
		;;
	*)
		echo "Unsupported OS: $OS_TYPE" >&2
		exit 1
		;;
esac

readonly __COLOR_RED='\033[0;31m'
readonly __COLOR_GREEN='\033[0;32m'
readonly __COLOR_YELLOW='\033[1;33m'
readonly __COLOR_RESET='\033[0m'
readonly __COLOR_CYAN='\033[0;36m'
declare -r NC='\033[0m'

##
# _info
# Print an informational message to stdout in green.
#
# @param $@ [string] The message to display.
##
function _info() {
	echo -e "${__COLOR_GREEN}[INFO]${__COLOR_RESET} $*"
}

##
# _warn
# Print a warning message to stdout in yellow.
#
# @param $@ [string] The warning message to display.
##
function _warn() {
	echo -e "${__COLOR_YELLOW}[WARN]${__COLOR_RESET} $*" >&2
}

##
# _error
# Print an error message to stderr in red.
#
# @param $@ [string] The error message to display.
##
function _error() {
	local exit_code=$?
	local script_name="${BASH_SOURCE[1]##*/}"
	local func="${FUNCNAME[1]:-MAIN}"
	local line="${BASH_LINENO[0]}"
	local timestamp
	timestamp=$(date +"%Y-%m-%d %H:%M:%S")

	echo -e "${__COLOR_RED}[ERROR]${__COLOR_RESET} [$timestamp] [$script_name:$func:$line] $*" >&2
	exit 1
}

declare -i __DEBUG_COUNTER=0
##
# _debug
# Print a debug message if VERBOSE is true.
#
# @param $@ [string] The debug message to display.
# @env VERBOSE [bool] If true, enables debug logging.
##
function _debug() {
	if [[ "$VERBOSE" = true ]]; then
		__DEBUG_COUNTER=$((__DEBUG_COUNTER + 1))
		{
			echo -e "${__COLOR_YELLOW}[DEBUG]${__COLOR_RESET} (${__DEBUG_COUNTER}) $*"
		} 1>&2
	fi
}

# Script arguments
declare -- VERBOSE=false

# Base directory of the konfig repo.
declare -- KONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Subdirectory where backups are stored.
declare -r BACKUP_DIR="$KONFIG_DIR/backups"

# Script settings.
declare -i CHECKSUMS=0
declare -i DRY=0

readonly KONFIG_DIR="$HOME/konfig"
readonly CONFIG_DIR="$KONFIG_DIR/configs"

echo -e "${__COLOR_CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║         Dotfiles Installer & Symlinker       ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"

if [[ ! -d "$BACKUP_DIR" ]]; then
	_warn "Creating backup directory!"
	mkdir "$BACKUP_DIR"
fi

while :; do
	case "${1:-}" in
		--checksums | -c)
			CHECKSUMS=1
			;;
		--dry | -d)
			DRY=1
			;;
		-?*)
			error "Invalid command-line arguments"
			;;
		*) break ;;
	esac
	shift
done


[[ $DRY -eq 1 ]] && _warn "Dryrun enabled!"

_info "Processing [$KONFIG_DIR] > $CONFIG_DIR\n"

while IFS='|' read -r enabled source destination; do
	[[ "$enabled" != "1" ]] && continue
	
	source=$(eval echo "$source")
	destination=$(eval echo "$destination")
	file="$source"

	if [[ -f "$destination" ]]; then
		# Target destination file already exists.
		# Move it to our backups directory
		if [[ $DRY -eq 0 && $CHECKSUMS -eq 0 ]]; then
			mv "$destination" "$BACKUP_DIR"
		fi
	fi

	if [[ $CHECKSUMS -eq 1 ]]; then
		src_checksum=$(md5sum $source)
		dst_checksum=$(md5sum $destination)

		printf "> %s\n" "$src_checksum"
		printf "> %s\n" "$dst_checksum"

	elif [[ $DRY -eq 0 ]]; then
		_info "Executing symlink [$source] to [$destination]"
		ln -s -f "$source" "$destination"
	fi
	_debug "DONE\n"
done < <(grep -v '^#' "$CONFIG_DIR/settings.conf")

_info "Install complete!"

[[ $CHECKSUMS -eq 1 ]] && exit 0

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	_warn "Run 'source ~/.zshrc' manually to apply changes"
fi

alias refresh="source $HOME/.zshrc"
