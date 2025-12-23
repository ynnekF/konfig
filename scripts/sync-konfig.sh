#!/bin/bash
# if [ -n "$SSH_CLIENT" ]; then
#   # Running on cloud desktop, sync to macbook
#   MAC_IP=$(echo $SSH_CLIENT | cut -d' ' -f1)
#   rsync -avz --delete ~/konfig/ $USER@$MAC_IP:~/konfig/
# else
#   # Running on macbook, sync to cloud desktop
#   rsync -avz --delete ~/konfig/ $1:~/konfig/
# fi

# rsync
# -a: archive mode (preserves permissions, timestamps, etc.)
# -v: verbose output
# -z: compression during transfer
# --delete: removes files on destination that don't exist on source
rsync -chavz --delete ${1:-ynnekdesk}:~/konfig/ ~/konfig