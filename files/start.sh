#!/bin/sh
cp ${HOME}/configs/* ${HOME}/baseq3/
if [ -z "${SERVER_ARGS}" ]; then
    SERVER_ARGS="+exec server_ffa.cfg +map q3dm17"
fi

if [ -z "${ADMIN_PASSWORD}" ]; then
    ADMIN_PASSWORD=$(cat /dev/urandom | head -c${1:-32} | base64)
    echo "No admin password set; defaulting to ${ADMIN_PASSWORD}."
fi

SERVER_BIN=$(ls ${HOME}/ioq3ded*)
if [ $(echo ${SERVER_BIN} | wc -l) -gt 1 ]; then
    echo "More than one files found:"
    echo ${SERVER_BIN}
    echo "Cannot determine name of ioquake3 server executable."
    exit 1
fi

${SERVER_BIN} \
    +seta rconPassword "${ADMIN_PASSWORD}" \
    +exec common.cfg \
    ${SERVER_ARGS}
