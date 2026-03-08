#!/bin/bash

# The MAC address of your device
MAC_ADDRESS="EC:81:93:F9:2E:DC"

echo "Attempting to connect to $MAC_ADDRESS..."

# Power on bluetooth just in case it's off
bluetoothctl power on

# Attempt to connect
# We use a timeout or a simple command to trigger the connection
bluetoothctl connect $MAC_ADDRESS

if [ $? -eq 0 ]; then
    echo "Successfully connected!"
else
    echo "Connection failed. Make sure the device is in pairing mode or nearby."
fi