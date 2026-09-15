#!/bin/bash

SERVICE1="RPI_MUTE.service"
SERVICE2="Demo_App_ACS.service"

if systemctl is-active --quiet $SERVICE1; then
    echo "$SERVICE1 is active. Switching to $SERVICE2..."
    sudo /usr/bin/systemctl stop $SERVICE1
    sudo /usr/bin/systemctl disable $SERVICE1
    sudo /usr/bin/systemctl enable $SERVICE2
    sudo /usr/bin/systemctl start $SERVICE2

elif systemctl is-active --quiet $SERVICE2; then
    echo "$SERVICE2 is active. Switching to $SERVICE1..."
    sudo /usr/bin/systemctl stop $SERVICE2
    sudo /usr/bin/systemctl disable $SERVICE2
    sudo /usr/bin/systemctl enable $SERVICE1
    sudo /usr/bin/systemctl start $SERVICE1

else
    echo "No service is currently active. Starting $SERVICE1 by default..."
    sudo /usr/bin/systemctl enable $SERVICE1
    sudo /usr/bin/systemctl start $SERVICE1
fi
