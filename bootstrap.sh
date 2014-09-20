#!/usr/bin/env bash

# Replace PROJECT_DIR with name of this dir on host
ln -fs /vagrant /home/vagrant/PROJECT_DIR

echo "I am "
whoami
echo "Present working dir "
pwd

. /vagrant/rails_env_install.sh

