#!/bin/sh

#/mnt/platform/libexec/udev/udevd --daemon
#hzq

/sbin/udevd --daemon
/sbin/udevadm trigger --action=add


