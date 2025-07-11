#!/bin/bash
#
# Install files from repository to their respective paths
# under $HOME
#
set -e

declare -r YELLOW='\033[1;33m'
declare -r GREEN='\033[0;32m'
declare -r CYAN='\033[0;36m'
declare -r RED='\033[0;31m'
declare -r NC='\033[0m'

declare -- KONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -r BACKUP_DIR="$KONFIG_DIR/backups"
declare -i DRY=0

function info() {
	local message="$1" && echo -e "${message}"
}

function warn() {
	local message="$1" && echo -e "${YELLOW}${message}${NC}"
}

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║         Dotfiles Installer & Symlinker       ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"

if [[ ! -d "$BACKUP_DIR" ]]; then
	warn "Creating backup directory!"
	mkdir "$BACKUP_DIR"
fi

info "konfig directory --> $KONFIG_DIR"
info "backup directory --> $BACKUP_DIR"

while :; do
	case "${1:-}" in
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

[[ $DRY -eq 1 ]] && warn "Dryrun enabled!"

SYMLINK_FILES=(
	zshrc
	init.vim
)

for file in "${SYMLINK_FILES[@]}"; do
	source=$(basename "$file")

	# Customization of the destination of the
	# configuration files we're setting up.
	destination=
	case "$source" in
		"zshrc")
			destination="$HOME/.zshrc"
			;;
		"init.vim")
			destination="$HOME/.config/nvim/init.vim"
			;;
	esac

	if [[ -f "$destination" ]]; then
		# Target destination file already exists.
		# Move it to our backups directory
		if [[ $DRY -eq 0 ]]; then
			mv "$destination" "$BACKUP_DIR/$source"
		fi

	fi

	printf ">> ${CYAN}%-15s${NC} ${GREEN}%10s${NC}\n" "$source" "$destination"
	if [[ $DRY -eq 0 ]]; then
		ln -s "$KONFIG_DIR/$source" "$destination"
	fi
done

info "install complete!"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	warn "run 'source ~/.zshrc' manually to apply changes"
fi
