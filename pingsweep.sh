#!/bin/bash

echo "enter your subnet:"
echo "ex. 192.168.1"
read SUBNET
for ip in $(seq 1 254); do
ping -c 1 $SUBNET.$ip
trap exit INT
done
