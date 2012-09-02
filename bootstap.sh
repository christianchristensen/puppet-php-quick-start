#!/bin/bash
sudo apt-get update
# https://github.com/aussielunix/jenkins-appliance/blob/master/Capfile#L31-43
# (old) https://gist.github.com/821847
sudo apt-get install -yq puppet git-core ruby1.8 libopenssl-ruby ruby rubygems ruby-bundler
sudo gem install librarian-puppet --no-ri --no-rdoc
