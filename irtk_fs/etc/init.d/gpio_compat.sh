#!/bin/sh

#radio
sq=60
mkdir -p /dev/radio
echo "${sq}" > /sys/class/gpio/export
ln -s /sys/class/gpio/gpio"${sq}"/value /dev/radio/sq
ln -s /sys/bus/iio/devices/iio:device1/in_voltage5_raw /dev/radio/rssi


#gprs
dcd=84
mkdir -p /dev/gprs
echo "${dcd}" > /sys/class/gpio/export
ln -s /sys/class/gpio/gpio"${dcd}"/value /dev/gprs/dcd


