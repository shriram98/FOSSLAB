#!/bin/bash

#converting pdf to text file usig pdftotext
pdftotext -layout RESULT.pdf

#getting csb details
#wget http://14.139.184.212/ask/c4b/c4b.txt

#collecting details of only CS students
cat RESULT.txt | grep MDL16CS > RESULT_CS.txt

#filtering CSB students list
cut -d$'\t' -f4 c4b.txt > temp.txt
join -2 1 temp.txt RESULT_CS.txt 1>RESULT_CSB.txt 2>/dev/null
rm temp.txt

#reorder the file by removing unnecesary spaces
cat RESULT_CSB.txt | tr -d '' > temp.txt
rm RESULT_CSB.txt
mv temp.txt RESULT_CSB.txt

#getting the grades of each student

cat RESULT_CSB.txt | cut -d' ' -f1 > head.txt

for i in {2..9}
do
  cat RESULT_CSB.txt | cut -d'(' -f$i | cut -d')' -f1 > temp_col_$i.txt
done

paste head.txt temp_col_*.txt > RESULT_FINAL.txt
rm temp_col_*.txt
rm head.txt

cp RESULT_FINAL.txt temp.txt

touch sgpa.txt
#finding the sgpa
while read -r line
do
  for i in {2..9}
  do
    string=$(echo $line | cut -d' ' -f$i)
    NAME[$((i-2))]=$string
  done
  
  #echo ${NAME[*]}
  #credits={4,4,3,1,1,4,3,3}
  credits[0]=4
  credits[1]=4
  credits[2]=3
  credits[3]=1
  credits[4]=1
  credits[5]=4
  credits[6]=3
  credits[7]=3
  
  #echo ${NAME[*]}
  sgpa=0;
  for j in {0..7}  
  do
    sum=0
    #echo ${NAME[j]}
    case ${NAME[j]} in 
      O)
        sum=$(( 10 * ${credits[j]} ))
        ;;
      A+)
        sum=$(( 9 * ${credits[j]} ))
        ;;
      A)
        sum=$(( 8 * ${credits[j]} ))
        ;;
      B+)
        sum=$(( 7 * ${credits[j]} ))
        ;;
      B)
        sum=$(( 6 * ${credits[j]} ))
        ;;
      C)
        sum=$(( 5 * ${credits[j]} ))
        ;;
      P)
        sum=$(( 4 * ${credits[j]} ))
        
        ;;
      F)
        sum=$(( 3 * ${credits[j]} ))
        ;;
      *)
        echo "invalid grade"
        ;;
      esac
      sgpa=$(( sgpa + sum ))
    done
    sgpa=$(( sgpa / 23 ))
    echo $sgpa >> sgpa.txt  

done< temp.txt
rm RESULT_*.txt
paste temp.txt sgpa.txt > RESULT_FINAL.txt
rm temp.txt
rm sgpa.txt
head RESULT_FINAL.txt
