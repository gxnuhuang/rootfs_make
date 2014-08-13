#!/bin/sh

if [ -e /dev/mmcblk"$1" ]
then
	insmod /etc/init.d/g_mass_storage.ko file=/dev/mmcblk"$1"p1 luns=1 ro=0stall=0 removable=1 iSerialNumber=3000111 iProduct=zhdgnss iManufacturer=zhd_survey
fi

