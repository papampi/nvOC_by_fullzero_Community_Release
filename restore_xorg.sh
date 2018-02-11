#!/bin/bash
echo "Restoring nvOC default xorg.conf"
cd /home/m1/Downloads
wget -N https://raw.githubusercontent.com/papampi/nvOC_by_fullzero_Community_Release/19-2.1/xorg.conf
sudo cp /etc/X11/xorg.conf /etc/X11/xorg.conf.bak
sudo cp /home/m1/Downloads/xorg.conf /etc/X11/xorg.conf
sudo cp /home/m1/Downloads/xorg.conf /etc/X11/xorg.conf.back
echo "Default xorg.conf and xorg.conf.back restored in /etc/X11/, reboot in 5 seconds"
sleep 5
sudo reboot
