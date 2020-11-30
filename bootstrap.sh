#!/bin/bash

apt-get update && apt-get upgrade
apt-get install aptitude -y
apt-get install apt-transport-https ca-certificates curl software-properties-common python3-pip virtualenv python3-setuptools emacs -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo apt-get install python3-pip mininet -y
pip3 install mininet 
#apt-get install openvswitch-testcontroller -y
#ln /usr/bin/ovs-testcontroller /usr/bin/controller 
#fuser -k 6653/tcp

