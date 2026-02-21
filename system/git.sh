#!/bin/bash

ssh-keygen -t ed25519 -C "ihor.dyrman@outlook.com" -f ~/.ssh/github
ssh-add ~/.ssh/github

git config --global user.name "Ihor"
git config --global user.email "ihor.dyrman@outlook.com"

git config --global core.editor "nvim"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global branch.sort -committerdate
git config --global tag.sort version:refname

git config --global diff.algorithm histogram
git config --global diff.colorMoved plain
git config --global diff.mnemonicPrefix true
git config --global diff.renames true

git config --global push.default simple
git config --global push.autoSetupRemote true
git config --global push.followTags true

git config --global fetch.prune true
git config --global fetch.pruneTags true
git config --global fetch.all true

echo "Done!"
