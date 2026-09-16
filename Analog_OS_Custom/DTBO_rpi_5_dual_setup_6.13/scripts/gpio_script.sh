#!/bin/bash
# Script to toggle MAX96717 serializer resets manually with sudo

# Export GPIOs if not already exported
if [ ! -d /sys/class/gpio/gpio623 ]; then
  sudo sh -c 'echo 623 > /sys/class/gpio/export'
fi
if [ ! -d /sys/class/gpio/gpio634 ]; then
  sudo sh -c 'echo 634 > /sys/class/gpio/export'
fi

# Set directions to output
sudo sh -c 'echo out > /sys/class/gpio/gpio623/direction'
sudo sh -c 'echo out > /sys/class/gpio/gpio634/direction'

echo "Asserting resets (GPIOs 623 and 634 low)"
sudo sh -c 'echo 0 > /sys/class/gpio/gpio623/value'
sudo sh -c 'echo 0 > /sys/class/gpio/gpio634/value'

sleep 1

echo "Deasserting resets (GPIOs 623 and 634 high)"
sudo sh -c 'echo 1 > /sys/class/gpio/gpio623/value'
sudo sh -c 'echo 1 > /sys/class/gpio/gpio634/value'

echo "Reset toggle complete. Check dmesg for link status."
