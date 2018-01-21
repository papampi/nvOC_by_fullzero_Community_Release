
Open Gparted, root password is miner1, Locate your drive, there are 2 partitions, a 9Mb fat, a 16Gb ext4 and a free unused space at the end. 

1- Make swap partition (Skip for USB install)
Right click on the unused space, create new partition, "Partition Type : Swap" make the size you want (1Gb up to Ram size) grab and move it to the end of drive. 
Apply.

2- Expand root partition:
Right click on the primary 16gb partition, resize/move, resize it to the desired size (better to give it all). 
Apply. (skip to step 5 for usb installs)

3- Applying Swap partition (skip this for USB Installs)

Right click on the swap partition and get the info, copy the UUID. 

open /etc/fstab with this command

```
gksudo gedit /etc/fstab
```

You will see a line which refers to a swap partition during installation ... 

Some thing similar to this :


```#swap was on /dev/sda5 during installation
UUID=cdba7b01-5ae6-4104-9a6e-f723b8bd87ac none            swap    sw              0       0
```


Change the UUID with the one you copied from newly made swap partition.

Save and close gedit.

Activate swap:

```
sudo swapon --all
```

It will read your fstab and enable the swap partition.

4- Check swap partition with free command

```
free

             total        used        free      shared  buff/cache   available
             
Mem:        8171388     3020388     2637404      142044     2513596     4647472

Swap:       8123388           0     8123388

```

5- Check partition size with:

```

df -h
```

reboot
