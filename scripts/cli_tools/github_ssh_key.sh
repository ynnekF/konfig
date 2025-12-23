#!/bin/bash

[[ -z "$1" ]] && exit 1

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/github_rsa
ssh-add -l -E sha256
ssh-keygen -t rsa -b 4096 -C "$1" -f ~/.ssh/github_rsa -q -N ""

ssh -T git@github.com