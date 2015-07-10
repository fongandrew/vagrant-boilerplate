#!/usr/bin/env bash

# Call this script after vagrant destroy to clean up old info pertaining to
# a previous virtual machine

# Remove old public key entry for localhost
sed -i '/\[localhost\]:8022/d' ~/.ssh/known_hosts

# Remove the flag we set about initialization being done
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -f $DIR/../.vagrant/init-complete.flag ]; then
  rm $DIR/../.vagrant/init-complete.flag
fi
