#!/bin/bsah
if [$#-ne 1];
then
	echo "invalid number of arguements";
	exit 0;
fi
while [true];

	USAGE=$(ps -eo pid -o pcpu -o command --no headers | sort -nrk 2 |head -n 1 | cut -d "." -f1 |echo $#
if [ "$#" != 2 ]
then
	echo "3 parameters required $2"
else
	echo $?
	grep $1 $2
	x=$?
	echo $x
	if [ $x = 1 ] 
	then
		echo "user details has been saved"
		echo $1 >> $2
	else
		echo "user found"
	fi
fi
