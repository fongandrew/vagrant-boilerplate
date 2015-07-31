#!/usr/bin/env bash

# FILENAME TO USE FOR PROFILE
PROFILENAME="profile"

# Where on host machine to sync
HOSTPATH="project"

# Sync target for guest (vagrant) VM
GUESTUSER="vagrant"
GUESTPORT="8022"
GUESTPATH="/home/$GUESTUSER/project"
GUESTROOT="ssh://$GUESTUSER@localhost:$GUESTPORT/$GUESTPATH"

# Create profile with unioson options
# * Repeat continously (unision-fsmonitor should be in directory as well)
# * Prefer host path over guest
# * Don't mess with permissions (this gets weird when syncing Linux / Windows)
# * Ignore certain files and directories
PROFILE="root = $HOSTPATH
\nroot = $GUESTROOT
\nignore = Name {.git,.vagrant}
\n
\nprefer = $HOSTPATH
\nrepeat = watch
"

# Get our current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Add ignorearchives option if first run
if [ ! -f $DIR/../.vagrant/init-complete.flag ]; then
  PROFILE="$PROFILE\nignorearchives = true"
  touch $DIR/../.vagrant/init-complete.flag
fi

# Write profile out
if [ -z ${USERPROFILE} ]; then # Unix
  PROFILEDIR="$HOME/.unison/"
  PROFILEPATH="$HOME/.unison/$PROFILENAME.prf"
else # Windows
  PROFILEDIR=$(cygpath -aw "$USERPROFILE\\.unison")
  PROFILEPATH=$(cygpath -aw "$USERPROFILE\\.unison\\$PROFILENAME.prf")
fi
mkdir -p $PROFILEDIR
echo -e $PROFILE > $PROFILEPATH

# Ensure guestpath exists (Unison chokes on this sometimes if it doesn't)
$DIR/ssh.sh "mkdir -p $GUESTPATH"

# unison.exe (and unision-fsmonitor.exe) should be in same directory as
# this script
UNISONEXE="$DIR/unison.exe"

$UNISONEXE $PROFILENAME
