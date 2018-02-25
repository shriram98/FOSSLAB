#!/bin/bash

echo -e "Your System information : \n"
echo  "kernel Name : $(uname -s)"
echo  "Kernel Release : $(uname -r)"
echo  "Kernel Version : $(uname -v)"
echo  "Operating System : $(uname -o)"
echo -e "\nAvailable Shells : $(cat /etc/shells)"
echo -e "\n CPU info : $(lscpu)"
echo -e "\n\n Memory Usage : $(free -h)"
echo -e "\n Hard Drive Details : $(sudo fdisk -l)"
echo -e "\n List of mounted File Systems : $(cat /proc/mounts | less)"
