#!/usr/bin/env bash

# Where on host machine to sync
HOSTPATH="project"

# Sync target for guest (vagrant) VM
GUESTUSER="vagrant"
GUESTPORT="8022"
GUESTPATH="/home/$GUESTUSER/project"
GUESTROOT="ssh://$GUESTUSER@localhost:$GUESTPORT/$GUESTPATH"

# Get our current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure guestpath exists (Unison chokes on this sometimes if it doesn't)
$DIR/ssh.sh "mkdir -p $GUESTPATH"

# unison.exe (and unision-fsmonitor.exe) should be in same directory as
# this script
UNISONEXE="$DIR/unison.exe"

# Unison options
# * Repeat continously (unision-fsmonitor should be in directory as well)
# * Prefer host path over guest
# * Don't mess with permissions (this gets weird when syncing Linux / Windows)
OPTIONS="-repeat watch -prefer $HOSTPATH -dontchmod -perms 0"

# Add ignorearchives option if first run
if [ ! -f $DIR/../.vagrant/init-complete.flag ]; then
  OPTIONS="$OPTIONS -ignorearchives"
  touch $DIR/../.vagrant/init-complete.flag
fi

$UNISONEXE $HOSTPATH $GUESTROOT $OPTIONS
