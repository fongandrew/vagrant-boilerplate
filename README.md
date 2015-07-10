# vagrant-boilerplate
Basic setup and bootstrapping for an Ubuntu 14.04 guest running on Windows / Cygwin host.

Basic Tasks
-----------
* Installs the public key in the provisioning folder as one of the authorized keys (NB: this is my personal public key -- use your own if you're cloning).
* Preserves SSH agent-forwarding (you need to SSH in using your own key though, not using `vagrant ssh` for this)
* Sets up a prettier bash shell than the default.
* Installs various common packages (git, build-essential, etc.)

Syncing
-------
This setup uses Unison to keep the files in the `project` directory in sync with `/home/vagrant/project`. The Unison binaries for both Windows and Ubuntu are provided in the `provisioning` directory because the versions need to match exactly and because the Ubuntu repository's version is out-of-date.

To start syncing, call `bin/sync.sh` after `vagrant up`. To sync a different path than the `project` directory, edit the `bin/sync.sh` file accordingly.


