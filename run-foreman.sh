#!/bin/sh
if [ -f "/etc/foreman/.install-complete" ]; then
    exec /bin/bash -c "tail -50f /var/log/foreman/production.log"
    exit 0
fi
#Install
echo "Installing Foreman, please wait..."
foreman-installer
echo "Configuring Foreman, please wait..."

#Create lock file so that next time we just start up
touch /etc/foreman/.install-complete
