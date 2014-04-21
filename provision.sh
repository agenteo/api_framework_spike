#!/usr/bin/env bash


echo "## Installing mongodb"
sudo apt-get update -y
sudo apt-get install mongodb -y

echo "## Installing RVM"
sudo apt-get install -y curl
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm # reload RVM
source /etc/profile.d/rvm.sh
rvm install ruby-2.1.0
rvm gemset use global
gem install bundler

sudo apt-get install -y tmux
sudo apt-get install -y vim
sudo apt-get install -y git
sudo apt-get install -y apache2-utils
sudo apt-get install -y httperf

ln -s /vagrant/apps ~/apps
cd apps/content_editor_api_rails
bundle
cd apps/content_editor_api_rails-api
bundle

echo "********************************************************************************"
echo "********************************************************************************"
echo "********************************************************************************"
