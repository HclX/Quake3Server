#!/bin/sh
SERVER_BIN=$(ls ${HOME}/ioq3ded*)
if [ $(echo ${SERVER_BIN} | wc -l) -gt 1 ]; then
    echo "More than one files found:"
    echo ${SERVER_BIN}
    echo "Cannot determine name of ioquake3 server executable."
    exit 1
fi

echo "============================================================================================================================================"
echo "$(date '+[%Y-%m-%d %H:%M:%S']) Starting IO Quake3 server ...."
cp -r -u /q3a/baseq3 $HOME/

if [ ! -f "$HOME/.q3a/baseq3/server.cfg" ]; then
    cp $HOME/configs/* $HOME/.q3a/baseq3/
fi

if [ -z "${ADMIN_PASSWORD}" ]; then
    ADMIN_PASSWORD=$(cat /dev/urandom | head -c${1:-32} | base64)
    echo "$(date '+[%Y-%m-%d %H:%M:%S']) No admin password set; defaulting to ${ADMIN_PASSWORD}."
fi

${SERVER_BIN} +seta rconPassword "${ADMIN_PASSWORD}" +exec server.cfg 2>&1 | awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0; fflush(); }'

echo "$(date '+[%Y-%m-%d %H:%M:%S']) Shuting down ...."
echo "============================================================================================================================================"
