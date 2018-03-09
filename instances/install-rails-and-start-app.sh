#!/bin/sh
sudo apt-get update
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
sudo apt-get install -y git
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install -l
rbenv install 2.4.1
rbenv global 2.4.1
ruby -v
echo "gem: --no-document" > ~/.gemrc
gem install bundler
gem env home    
gem install rails
rbenv rehash
rails -v
git clone https://github.com/spsiddarthan/sample-app
cd sample-app
exec > >(tee /var/log/install-rails-and-start-app.log|logger -t install-rails-and-start-app  -s 2>/dev/console) 2>&1
echo "Starting Ruby on Rails app "
rails -s &
