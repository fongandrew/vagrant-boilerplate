# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box = "ubuntu/trusty64"
  # This box has NFS built in already
  config.vm.box = "cmad/trusty-server64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 21, host: 8021
  config.vm.network "forwarded_port", guest: 22, host: 8022
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 9300, host: 9300

  # Boost memory
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  # Ensure that SSH agent forwarding is true so that we can use Vagrant as
  # control machine without having to copy keys over to virtual machine
  config.ssh.forward_agent = true

  # Install requirements directly with shell script
  config.vm.provision :shell, :path => "bootstrap.sh"
end
