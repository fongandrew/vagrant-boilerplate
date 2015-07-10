#!/usr/bin/env bash

# Where on host machine to sync
HOSTPATH="project"

# Sync target for guest (vagrant) VM
GUESTUSER="vagrant"
GUESTPORT="8022"
GUESTPATH="/home/$GUESTUSER/project"
GUESTROOT="ssh://$GUESTUSER@localhost:$GUESTPORT/$GUESTPATH"

# unison.exe (and unision-fsmonitor.exe) should be in same directory as
# this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UNISONEXE="$DIR/unison.exe"

# Unison options
# * Repeat continously (unision-fsmonitor should be in directory as well)
# * Prefer host path over guest
# * Don't mess with permissions (this gets weird when syncing Linux / Windows)
OPTIONS="-repeat watch -prefer $HOSTPATH -dontchmod -perms 0"

$UNISONEXE $HOSTPATH $GUESTROOT $OPTIONS
