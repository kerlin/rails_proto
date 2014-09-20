#!/bin/bash

# Run only once on host to set up git

if whoami | grep vagrant >/dev/null
then
  echo "Run this script on host"
  exit
else
  echo "Ok, running on host"
fi

# setup for git and github
# expects git installed with heroku toolbelt

if which git | grep git > /dev/null
then
  echo "Found git"
else
  echo "Install git first"
  exit
fi

cd ~

# see help set
# -e exit immediately if a command exits with a non-zero status.
set -e

if [ ! -s ~/.gitconfig ]
then
  git config --global user.name kerlin
  git config --global user.email chris.kerlin@gmail.com
else
  echo "~/.gitconfig exists"
fi

# see https://help.github.com/articles/generating-ssh-keys
if ssh -T git@github.com | grep kerlin > /dev/null
then
  echo "Github authentication successful."
  exit
fi

if [ ! -s ~/.ssh/id_rsa.pub ]
then
  ssh-keygen -t rsa -C "chris.kerlin@gmail.com"
else
  echo "public key exists"
fi

echo "Log in to github at https://github.com/settings/ssh"
echo "enter this key:"
cat ~/.ssh/id_rsa.pub

