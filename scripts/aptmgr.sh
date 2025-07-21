#!/bin/bash

declare -- VERSION="1.0.0"

IFS=$'\n\t'

# Exit immediately on any non-zero status
set -e

# Exit on unset variables
set -u

# Crash pipeline
set -o pipefail

readonly __COLOR_RED='\033[0;31m'
readonly __COLOR_GREEN='\033[0;32m'
readonly __COLOR_YELLOW='\033[1;33m'
readonly __COLOR_RESET='\033[0m'

function show_upgradable() {
	echo -e "\n${__COLOR_YELLOW}Upgradable packages:${__COLOR_RESET}"
	apt list --upgradable 2>/dev/null | grep -v 'Listing...' | sort
}

function show_installed() {
	echo -e "\n${__COLOR_YELLOW}Installed packages:${__COLOR_RESET}"
	apt list --installed | grep -Ff <(apt-mark showmanual) | sort | uniq
}

function show_all() {
	echo -e "\n${__COLOR_YELLOW}All installed packages:${__COLOR_RESET}"
	# View packages explicitly installed by the user
	apt-mark showmanual | sort | uniq | while read -r package; do
		# Check if the package is installed
		if dpkg -l | grep -q "^ii\s\+$package"; then
			echo "$package"
		else
			echo "Package $package is not installed."
		fi
	done
}

##
# main
# Entry point for script logic.
##
function main() {
	while :; do
		case "${1:-}" in
			--upgradable | -u)
				show_upgradable
				;;
			--installed | -i)
				show_installed
				;;
			--all | -a)
				show_all
				;;
			-?*)
				_error "invalid command-line arguments"
				;;
			*) break ;;
		esac
		shift
	done
}

main "$@"
