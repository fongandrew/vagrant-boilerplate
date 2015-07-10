# vagrant-boilerplate
Basic setup and bootstrapping for an Ubuntu 14.04 guest running on 
Windows / Cygwin host.

Prerequisites
-------------
* Vagrant should be installed
* Virtualbox should be installed (other VMs could work too, but you need
  to change the Vagrantfile if so)
* Cygwin should be installed (it might be possible to just use Bash on a
  Windows prompt, but I haven't tested that).
* An SSH client and an SSH private key matching the public key in the 
  provisioning directory should be installed.

Basic Tasks
-----------
* Installs the public key in the provisioning folder as one of the authorized 
keys (NB: this is my personal public key -- use your own if you're cloning).
* Preserves SSH agent-forwarding (you need to SSH in using your own key though, 
  not using `vagrant ssh` for this)
* Sets up a prettier bash shell than the default.
* Installs various common packages (git, build-essential, etc.)

Syncing
-------
This setup uses Unison to keep the files in the `project` directory in sync 
with `/home/vagrant/project`. The Unison binaries for both Windows and Ubuntu 
are provided in the `provisioning` directory because the versions need to match 
exactly and because the Ubuntu repository's version is out-of-date. The 
`provisioning/bootstrap.sh` script installs Unison on the guest machine and
is called during `vagrant up`.

To sync a different path than the `project` directory, edit the `bin/sync.sh` 
file accordingly.

If things aren't working, consider taking a look at 
https://keylocation.sg/blog/vagrant-and-unison-without-a-plugin/ for more info.

Scripts
-------
* `bin/reset.sh` - Call this after `vagrant destroy` or if you get Unison 
  errors about misisng archive files.
* `bin/ssh.sh` - Call to ssh in using your own keys (rather than Vagrant's)
* `bin/sync.sh` - Call this to start Unison syncing. `Ctrl+C` to stop.

