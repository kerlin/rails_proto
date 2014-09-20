#!/bin/bash

# Create a new rails project on vagrant

if whoami | grep vagrant >/dev/null
then
  echo "Ok, running on vagrant"
else
  echo "Run this script on vagrant"
  exit
fi

rails new PROJECT_DIR -T -d postgresql
# git clone https://github.com/heroku/ruby-rails-sample.git

