#!/bin/sh
OLD_UID=$(id -u $Q3SVR_USER)
OLD_GID=$(id -g $Q3SVR_USER)

NEW_UID=${PUID:-$OLD_UID}
NEW_GID=${PGID:-$OLD_GID}

if [ "$NEW_UID" -ne "$OLD_UID" ]; then
    usermod --uid $NEW_UID $Q3SVR_USER
    find / -user $OLD_UID -exec chown $NEW_UID {} \;
fi


if [ "$NEW_GID" -ne "$OLD_GID" ]; then
    usermod --gid $NEW_GID $Q3SVR_USER
    find / -group $OLD_GID -exec chgrp $NEW_GID {} \;
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
