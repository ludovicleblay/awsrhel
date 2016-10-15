sudo su
yum update
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install -y gcc-c++ make
yum -y install nodejs
curl -fsSL https://get.docker.com/ | sh
systemctl enable docker.service
systemctl start docker
systemctl enable docker
