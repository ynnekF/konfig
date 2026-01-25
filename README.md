#### GitHub Setup

```
> ssh -T git@github.com
git@github.com: Permission denied (publickey).

> ssh-add -l -E sha256
The agent has no identities.

> ssh-add ~/.ssh/github_rsa
Identity added: <ident>

> ssh -T git@github.com
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

##### Alternate approach with bare repo.

Setup Repo.
- git init --bare $HOME/.dotfiles
- (OPTIONAL) alias config='/usr/bin/git --git-dir=$HOME/.userfiles --work-tree='
- config remote add origin # Replace with your repo URL

Note: workTree should match the directory of the file being added to the repo. Otherwise, the entire file path will be added (path/to/file/)

Adding Files
- config add ~/.bashrc ~/.vimrc # Add desired dotfiles
- config commit -m "Initial dotfiles commit"
- config push -u origin master (or main)