#!/bin/bash

echo "enter your address:"
read ADDRESS
for ip in $ADDRESS; do
nmap -sC -sT -v -p- -oA nmap $address$ip
trap exit INT
done
