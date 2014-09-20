#!/bin/bash
# Basic setup for ruby and rails

if whoami | grep vagrant >/dev/null
then
  echo "Ok, running on vagrant"
else
  echo "Run this script on vagrant"
  exit
fi

#http://guides.rubyonrails.org/v3.2.13/getting_started.html#getting-up-and-running-quickly-with-scaffolding
#https://devcenter.heroku.com/articles/getting-started-with-rails4
#https://github.com/heroku/ruby-rails-sample
#https://www.railstutorial.org/book/static_pages
#http://railsapps.github.io/rails-heroku-tutorial.html

cd ~

# see help set
# -e exit immediately if a command exits with a non-zero status.
set -e

# see man apt-get or apt-get -h
# -y assume yes, -m handle missing packages, -q omit progress

echo "Update packages"
sudo apt-get -y update

echo "Install Dependencies"

# see http://railsapps.github.io/installing-rails.html
# Since Rails 3.1, a JavaScript runtime has been needed
# for development on Ubuntu Linux (it is not needed for Mac OS X or Windows)
sudo apt-get -y install nodejs

# Install build essential package for Debian.
sudo apt-get -y install build-essential

# Install curl to get files
# probably installed by default
sudo apt-get -y install curl

# Install Git
# Obsolete
#sudo apt-get install -y git-core
# Probably already installed
sudo apt-get install -y git
which git

# Install postgres
sudo apt-get install -y postgresql postgresql-contrib
sudo apt-get install -y libpq-dev
# http://guides.rubyonrails.org/configuring.html#configuring-a-database
# rake db:create
# rake db:migrate
# also db:schema:load, db:seed, db:setup, db:drop, etc.

# Create a postgres role who can login and create databases
sudo -u postgres createuser -d `whoami`

# Others that might be needed
#sudo apt-get -y install bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev

#echo "Install ImageMagick"
# see gem 'rmagick'
#sudo apt-get install -y -m imagemagick 
#may also need these
#sudo apt-get install -y -m libmagickcore-dev libmagickwand-dev

# Install RVM
# RVM stands for Ruby Version Manager and allows you to install
# multiple versions of Ruby and switch between them easily.
# Even if you are only going to use one version,
# it's probably the simplest way to install Ruby.

# install with ruby
#curl -L https://get.rvm.io | bash -s stable --ruby
# install stable release -sS hides progress but not errors, -L follow redirect location
\curl -sSL https://get.rvm.io | bash -s stable
# what it's really doing
#\curl https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable

# Make RVM known in your bash sessions:
# see http://rvm.io/workflow/scripting
# Load RVM into shell session as a function
# install adds path to .profile and starts rvm from .bash_profile
# is this necessary? .bashrc is for non-login shells
#echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
#. ~/.bashrc
# just do this instead
. ~/.profile
. ~/.bash_profile

# check if installed as function or binary
type rvm | head -1

# Using RVM
# You can get a list of Ruby versions by running
rvm list known

# The version of Ruby we will use is 2.1.2
# install it

rvm install ruby-2.1.2

# Set this version as the default

rvm use 2.1.2

# You can then make sure Ruby is installed by running the following command in your terminal window:

ruby -v

# Installing Rails

# The latest version of Rails will be installed - should be 4.0 or higher

gem install rails --no-ri --no-rdoc

# Verify that it was installed correctly

rails -v
