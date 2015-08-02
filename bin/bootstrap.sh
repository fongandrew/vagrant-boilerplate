#!/usr/bin/env bash

# This shell script is used to provision just Ansible + some essentials
# Remainder of provisioning is done via ansible and playbook.yaml

# Update apt
apt-get -y update

# Install some useful things
apt-get install -y build-essential gcc make patch coreutils net-tools dialog
apt-get install -y nano wget curl git tar

# Fix locale
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Set up passwordless sudo
echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

# Ensure SSH agent forwarding preserved during sudo access
echo "Defaults env_keep+=SSH_AUTH_SOCK" >> /etc/sudoers

# Make sure our vagrant user is using bash
chsh -s /bin/bash vagrant

# Install our public key
cat /home/vagrant/provisioning/public_key >> /home/vagrant/.ssh/authorized_keys

# Ensure vagrant user has access to nicer color scheme
cp /home/vagrant/provisioning/.bash_prompt /home/vagrant/.bash_prompt
echo "source ~/.bash_prompt" >> /home/vagrant/.bashrc

# Install Unison binaries
cp /home/vagrant/provisioning/unison-2.48.3-2-x86_64.pkg.tar.xz /
cd /
tar xf unison-2.48.3-2-x86_64.pkg.tar.xz
