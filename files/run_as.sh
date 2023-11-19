#!/bin/sh
PUID=${PUID:-$(id -u $Q3SVR_USER)}
PGID=${PGID:-$(id -g $Q3SVR_USER)}

usermod --uid $PUID --gid $PGID $Q3SVR_USER
su -s/bin/sh -c $Q3SVR_HOME/ioq3svr.sh $Q3SVR_USER
