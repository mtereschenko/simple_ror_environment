#!/bin/ash

cd /app

gem install rails

rails new . -d=postgresql --skip-git

yes | cp -rf /tmp/database.yml /app/config/database.yml
yes | cp -rf /tmp/development.rb /app/config/environments/development.rb
cp /tmp/.gitignore /app/.gitignore
