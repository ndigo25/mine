#!/bin/bash

echo -n "enter your address: "
read ADDRESS
for ip in $ADDRESS; do
nmap -sC -sT -v -p- -oA nmap $address$ip
echo -n "Here are your results. Would you like me to move them to a different directory? (Y/n): "
read RESULTS
if [[ $RESULTS =~ ^[Yy]$ ]]
then
echo -n "Where would you like me to move them?: "
read DIRECTORY
mv nmap.nmap nmap.gnmap nmap.xml $DIRECTORY
echo "Moved your results to" $DIRECTORY
if [[ $RESULTS =~ ^[Nn]$ ]]
then
exit 1
fi
fi
done
