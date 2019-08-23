#!/bin/bash
yum install unzip git java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
# Install fpm on centos
yum install ruby-devel gcc make rpm-build rubygems -y
gem install --no-ri --no-rdoc fpm
export PATH=$PATH:/usr/local/bin
fpm --version
