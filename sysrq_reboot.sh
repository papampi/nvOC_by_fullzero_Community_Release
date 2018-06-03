#!/bin/bash
# Safe Reboot Using Magic SysRq Key
# Suggested by abdeldev in bitcointalk forum


echo 1 > /proc/sys/kernel/sysrq

# (un*R*aw) Takes back control of keyboard from X
#echo r > /proc/sysrq-trigger

# (t*E*rminate) Send SIGTERM to all processes. 
#echo e > /proc/sysrq-trigger

# (k*I*ll) Send SIGKILL to all processes.
#echo i > /proc/sysrq-trigger

# (*S*nc) Sync all cached disk operations to disk
echo s > /proc/sysrq-trigger

# (*U*mount) Umounts all mounted partitions ##
echo u > /proc/sysrq-trigger

# (re*B*oot) Reboots the system
echo b > /proc/sysrq-trigger
