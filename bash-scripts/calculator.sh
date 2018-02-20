#!/bin/bash

count=0
while [ $count -eq 0 ]
do
  tput clear
  echo " Enter 1. for Addition"
  echo " Enter 2. for Subtraction"
  echo " Enter 3. for Multiplication"
  echo " Enter 4. for Division"
  echo " Enter 5. To Exit"
  echo -e "Enter Yr choice : \c"
  
  read choice

  if [ $choice -ne 5 ]
  then
    echo -e "Enter The first number: \c"
    read a
    echo -e "Enter second number : \c"
    read b
  fi
  case $choice in 
    1)  ans=$(( a + b ))
      echo "Addtion is $ans"
      ;;
    2)  ans=$(( a - b ))
      echo "Subtraction is $ans"
      ;;
    3)  ans=$(( a * b ))
      echo "Mult is $ans"
      ;;
    4)  ans=$(( a / b ))
      echo "Div is $ans"
      ;;
    5)  exit 1
      ;;
    *) echo "Invalid Choice"
      ;;
  esac
  sleep 3
done

