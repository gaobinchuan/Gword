#!/bin/bash
WORD_COUNT=`cat ~/.Gwords/list.txt | wc -l`
COUNT=$(( WORD_COUNT / 2 ))
echo $COUNT
for (( i = 1; i < $COUNT; i = i + 1 )) 
do
    en=`sed -n $(( i * 2 + 1 )),1p ~/.Gwords/list.txt | tr [:space:] ' '`
    cn=`sed -n $(( i * 2 + 2 )),1p ~/.Gwords/list.txt | tr [:space:] ' '`
    echo $en : $cn
    gr $en
    sleep 7
done
