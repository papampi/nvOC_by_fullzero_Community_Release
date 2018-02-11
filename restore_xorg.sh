#!/bin/bash
echo "Restoring nvOC default xorg.conf"
if [ -e /etc/X11/xorg.conf.default ]
then
  echo "Restore default xorg.conf"
  sudo cp '/etc/X11/xorg.conf.default' '/etc/X11/xorg.conf'
  sudo cp '/etc/X11/xorg.conf.default' '/etc/X11/xorg.conf.backup'
else
  echo "Downloading default xorg.conf"
  sudo wget -N https://raw.githubusercontent.com/papampi/nvOC_by_fullzero_Community_Release/19-2.1/xorg.conf -O /etc/X11/xorg.conf.default
  echo "Restore default xorg.conf"
  sudo cp '/etc/X11/xorg.conf.default' '/etc/X11/xorg.conf'
  sudo cp '/etc/X11/xorg.conf.default' '/etc/X11/xorg.conf.backup'
fi
echo "Default /etc/X11/xorg.conf restored, reboot in 5 seconds"
sleep 5
sudo reboot
