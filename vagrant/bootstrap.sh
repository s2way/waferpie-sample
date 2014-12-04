#!/usr/bin/env bash
curl -sL https://rpm.nodesource.com/setup | bash -
sudo yum install -y nodejs
sudo yum install -y gcc-c++ make
sudo yum install -y npm
sudo yum install -y git
npm install -g nodemon
npm install -g coffee-script
cd /vagrant
npm install
cd /home/vagrant/
git clone https://github.com/s2way/waferpie.git
cd waferpie
npm install
cd /vagrant
rm -rf node_modules/waferpie
ln -s /home/vagrant/waferpie /vagrant/node_modules/waferpie
nodemon index.js
