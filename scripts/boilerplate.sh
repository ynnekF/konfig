#!/bin/bash

###############################################################################
# Script Name:    boilerplate.sh
# Description:    boilerplate
# Author:         mr plate
# Created:        2025-07-11
###############################################################################
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

##
# usage
# Print usage/help message and exit.
##
function usage() {
	echo "Usage: $0 [options]"
	echo
	echo "Options:"
	echo "  -v, --verbose     Enable verbose output"
	echo "  -l, --log FILE    Log output to FILE"
	echo "  -h, --help        Show this help message"
	echo "  --version         Show script version"
	echo
}

# Script arguments
declare -- VERBOSE=false

##
# main
# Entry point for script logic.
##
function main() {
	while :; do
		case "${1:-}" in
			--dry | -d)
				DRY=1
				;;
			--verbose | -v)
				VERBOSE=true && _debug "DEBUG enabled"
				;;
			--ex | -e)
				EXAMPLE="${2-}"
				shift
				;;
			--help | -h)
				usage
				exit 0
				;;
			--version)
				echo "$VERSION"
				exit 0
				;;
			-?*)
				_error "invalid command-line arguments"
				;;
			*) break ;;
		esac
		shift
	done
	[[ "$VERBOSE" = true ]] && declare -F

	_info "Running $(basename $0)"
}

main "$@"
