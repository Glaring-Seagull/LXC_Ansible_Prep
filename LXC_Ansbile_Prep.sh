#!/bin/bash

#This script is for prepping LXC containers for SSH and Ansible use, inteded for systemd based systems

#checks for yum or apt then uses the detected package manager to install ssh and sudo; exits if neither is detected
if command -v apt-get >/dev/null; then
  apt install openssh-server sudo -y
elif command -v dnf >/dev/null; then
  dnf install openssh-server sudo -y
else
  echo "Not able to detect package manager! Canceling script!"
  exit 1
fi

#Configures permission to be accessed via SSH
echo "PermitRootLogin yes" >> /etc/ssh/ssh_config

#Enable ssh so it starts every time and restarts service to complete changes
systemctl enable sshd.service
systemctl restart sshd.service
