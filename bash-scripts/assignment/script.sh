#!/bin/bash

#function to calculate sgpa with argument as 1 for s1 and 2 for s2

function calculateSGPA {
  
  pdftotext -layout result$1.pdf result$1.txt
  tr -d '\014' <result$1.txt > temp.txt
  mv temp.txt result$1.txt

  #filtering list of cs students and pasting it in resultcs.txt
  paste <(grep MDL16CS result$1.txt) <(grep CS1$10\( result$1.txt) | tr -d ' ' > resultcs.txt

  touch grades.txt
  touch sgpa.txt

  #for loop to get grades of each student and paste it in grades.txt
  for i in {2..10}
  do
    paste grades.txt  <(cut -d'(' -f$i resultcs.txt | cut -d')' -f1) > temp.txt
    mv temp.txt grades.txt
  done

  #calculating sgpa from grades.txt and storing it in sgpa.txt
  #here bc() is used to do calculations in floating point as bash does not support flop

  if [ $1 -eq 1 ]
  then
    credits=(4 4 3 3 3 3 1 1 1)
  else
    credits=(4 4 3 1 1 4 3 3 1)
  fi

  while read -r line
  do
    sgpa=0
    for i in {2..10}
    do
      case "$(echo $line | cut -d' ' -f$i )" in
       O) sum=$(bc <<< "scale = 2; (10 * ${credits[i-2]})")
         ;;
       A+) sum=$(bc <<< "scale = 2; (9 * ${credits[i-2]})")
         ;;
       A) sum=$(bc <<< "scale = 2; (8.50 * ${credits[i-2]})")
         ;;
       B+) sum=$(bc <<< "scale = 2; (8 * ${credits[i-2]})")
         ;;
       B) sum=$(bc <<< "scale = 2; (7 * ${credits[i-2]})")
         ;;
       C) sum=$(bc <<< "scale = 2; (6 * ${credits[i-2]})")
         ;;
       P) sum=$(bc <<< "scale = 2; (5 * ${credits[i-2]})")
         ;;
       F) sum=$(bc <<< "scale = 2; (0 * ${credits[i-2]})")
         ;;
       *)sum=0
         ;;
     esac
     sgpa=$(bc <<< "scale = 2; ($sgpa + $sum) ")         
   done
    bc <<< "scale = 2; ($sgpa/(23 + $1 -1))" >> sgpa.txt
  done<grades.txt

  #getting csb student list
  #wget http://14.139.184.212/ask/c4b/c4b.txt

  #filtering only csb student sgpa and storing in SGPA.txt
  join <(cut -d$'\t' -f4 c4b.txt) <(paste <(grep MDL16CS result$1.txt | cut -d' ' -f1) sgpa.txt) > SGPA$1.txt 2>/dev/null 

  #removing temporary files
  rm resultcs.txt sgpa.txt grades.txt result$1.txt
  }

calculateSGPA 1
calculateSGPA 2

join SGPA1.txt <(cut -f2 SGPA2.txt) > SGPA.txt
rm SGPA1.txt SGPA2.txt

rm CGPA.txt 2>/dev/null
touch CGPA.txt

while read -r line
do
  bc <<< " scale = 2; ((($( echo $line | cut -d' ' -f2) * 23) + ($( echo $line | cut -d' ' -f3) * 24)) / 47)" >> CGPA.txt
done<SGPA.txt


paste <(cut -d' ' -f1 SGPA.txt) CGPA.txt > temp.txt
mv temp.txt CGPA.txt
