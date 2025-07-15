#!/bin/bash
#
###############################################################################
# Script Name:    ports.sh
# Description:    Display listening ports and active connections
# Author:         
# Created:        2025-07-14
###############################################################################
declare -- VERSION="1.0.0"

IFS=$'\n\t'

# Exit on unset variables
set -u

# Crash pipeline
set -o pipefail

# Define colors for the output to make it more readable.
# You can disable colors by setting these to empty strings.
readonly __COLOR_RED='\033[0;31m'
readonly __COLOR_GREEN='\033[0;32m'
readonly __COLOR_YELLOW='\033[1;33m'
readonly __COLOR_RESET='\033[0m'
readonly __COLOR_BOLD='\033[1m'
readonly __COLOR_BLUE='\033[0;34m'
readonly __COLOR_CYAN='\033[0;36m'

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

# 1. Check for root privileges. lsof needs it to inspect all processes.
if [[ $EUID -ne 0 ]]; then
   echo -e "${__COLOR_BOLD}${__COLOR_RED}Error:${__COLOR_RESET} This script must be run as root (or with sudo) to see all process information."
   exit 1
fi

# 2. Check if the 'lsof' command is available.
if ! command -v lsof &> /dev/null; then
    echo -e "${__COLOR_BOLD}${__COLOR_RED}Error:${__COLOR_RESET} The 'lsof' command was not found."
    echo "Please install it to use this script (e.g., 'sudo apt install lsof' or 'sudo yum install lsof')."
    exit 1
fi


# Prints a formatted header for the tables.
function print_header() {
    printf "${__COLOR_BOLD}${__COLOR_BLUE}%-15s %-8s %-22s %-8s %-40s${__COLOR_RESET}\n" "USER" "PID" "COMMAND" "PROTO" "ADDRESS:PORT / CONNECTION"
    printf "${__COLOR_BOLD}${__COLOR_BLUE}%s${__COLOR_RESET}\n" "--------------- -------- ---------------------- -------- ----------------------------------------"
}

# Processes the output from lsof and formats it into columns.
# It takes the protocol (TCP/UDP) as its first argument.
function format_lsof_output() {
    local proto="$1"
    # $1=COMMAND, $2=PID, $3=USER, $9=NAME (address/connection info)
    awk -v proto="$proto" '{
        printf "%-15s %-8s %-22s %-8s %-40s\n", $3, $2, $1, proto, $9
    }'
}

# 1. Display Listening Ports
echo -e "\n${__COLOR_BOLD}${__COLOR_GREEN}⦿ Listening Ports${__COLOR_RESET}"
print_header

# Get TCP listening ports and format them.
# -iTCP specifies TCP, -sTCP:LISTEN filters for the LISTEN state.
# -P prevents port name resolution (e.g., shows 80 instead of http).
# -n prevents hostname resolution (shows IP address instead of domain name).
lsof -iTCP -sTCP:LISTEN -P -n | format_lsof_output "TCP"

# Get UDP listening ports and format them.
# Note: UDP is stateless, so there is no "LISTEN" state. lsof simply shows
# open UDP sockets that are ready to receive data.
lsof -iUDP -P -n | format_lsof_output "UDP"

# 2. Display Active Established Connections
# First, check if there are any established connections to show.
if [ "$(lsof -iTCP -sTCP:ESTABLISHED -P -n | wc -l)" -gt 0 ]; then
    echo -e "\n${__COLOR_BOLD}${__COLOR_YELLOW}⦿ Active Established Connections${__COLOR_RESET}"
    print_header
    # Get and format all established TCP connections.
    lsof -iTCP -sTCP:ESTABLISHED -P -n | format_lsof_output "TCP"
else
    echo -e "\n${__COLOR_BOLD}${__COLOR_CYAN}⦿ No active established connections found.${__COLOR_RESET}"
fi

echo "" # Add a final newline for clean exit.
