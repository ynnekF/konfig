#!/bin/bash

sudo yum groupinstall 'Development Tools'
sudo yum install curl file git
sudo yum install libxcrypt-compat

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"