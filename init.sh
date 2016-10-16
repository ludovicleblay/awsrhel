#!/bin/sh

sudo su
yum -y update
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum -y install gcc-c++ make
yum -y install nodejs
yum -y install git
npm install -g grunt-cli
npm install -g pm2
npm config set registry http://10.21.182.123:4873/
git config --global http.sslverify false
curl -fsSL https://get.docker.com/ | sh
systemctl enable docker.service
systemctl start docker
systemctl enable docker
rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
yum -y install openconnect vpnc
exit

