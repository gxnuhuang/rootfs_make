#!/bin/sh

autoformat() {
	echo -n "mount disk failure, do you want to format the disk?<Y/N>:"
	read choice
	if [ $choice = "N" ]
	then
		exit 0;
	fi

	if [ $choice = "Y" ]
	then
		echo -n "start formatting disk..."

		if test -f /etc/partition_info.conf
		then
			cat /etc/partition_info.conf | grep -v ^# > /tmp/fmt_info_temp
			fdisk /dev/mmcblk"$1" < /tmp/fmt_info_temp
		fi

		echo "ok"
	fi
}

#check the integrity of partition table
if  ! ( test -b /dev/mmcblk"$1"p1 && test -b /dev/mmcblk"$1"p2 && test -b /dev/mmcblk"$1"p3 ) then
	autoformat $1
fi

#check if each partition is correctly formated
/bin/mount -t auto -o rw /dev/mmcblk"$1"p1 /mnt/storage
if [ $? -ne 0 ]; then	
	echo "formating mmcblk"$1"p1"
	mkfs.vfat /dev/mmcblk"$1"p1
	/bin/mount -t auto -o rw /dev/mmcblk"$1"p1 /mnt/storage
fi

/bin/mount -t auto -o rw /dev/mmcblk"$1"p2 /mnt/firmware
if [ $? -ne 0 ]; then	
	echo "formating mmcblk"$1"p2"
	mkfs.vfat /dev/mmcblk"$1"p2
	/bin/mount -t auto -o rw /dev/mmcblk"$1"p2 /mnt/firmware
fi

/bin/mount -t auto -o rw /dev/mmcblk"$1"p3 /mnt/platform
if [ $? -ne 0 ]; then	
	echo "formating mmcblk"$1"p3"
	mkfs.ext2 /dev/mmcblk"$1"p3
	/bin/mount -t auto -o rw /dev/mmcblk"$1"p3 /mnt/platform
fi


