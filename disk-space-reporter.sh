#!/bin/bash

MAIL="emailkamu@namadomain.xxx"  
UKURANMAX=85  
HOST=`uname -ar | awk '{print $2}'`

for SIZE in `df -h | grep sda7 | awk '{print $5}' | sed 's/%//g'`  
do  
if [ $SIZE -gt $UKURANMAX ]  
then  
mail -s "partition $HOST / hampir penuh" $MAIL << EOF  
partisi / $HOST sudah mau penuh. / $SIZE%  
EOF  
fi  
done

#untuk home
for SIZEHOME in `df -h | grep sda3 | awk '{print $5}' | sed 's/%//g'`  
do  
if [ $SIZEHOME -gt $UKURANMAX ]  
then  
mail -s "partition $HOST /home hampir penuh" $MAIL << EOF  
partisi /home $HOST sudah mau penuh. /home $SIZEHOME%  
EOF  
fi  
done

#untuk tmp
for SIZETMP in `df -h | grep sda4 | awk '{print $5}' | sed 's/%//g'`  
do  
if [ $SIZETMP -gt $UKURANMAX ]  
then  
mail -s "partition $HOST /tmp hampir penuh" $MAIL << EOF  
partisi /tmp $HOST sudah mau penuh. /tmp $SIZETMP%  
EOF  
fi  
done

#untuk usr
for SIZEUSR in `df -h | grep sda5 | awk '{print $5}' | sed 's/%//g'`  
do  
if [ $SIZEUSR -gt $UKURANMAX ]  
then  
mail -s "partition $HOST /usr hampir penuh" $MAIL << EOF  
partisi /usr $HOST sudah mau penuh. /usr $SIZEUSR%  
EOF  
fi  
done

#untuk var
for SIZEVAR in `df -h | grep sda2 | awk '{print $5}' | sed 's/%//g'`  
do  
if [ $SIZEVAR -gt $UKURANMAX ]  
then  
mail -s "partition $HOST /var hampir penuh" $MAIL << EOF  
partisi /var $HOST sudah mau penuh. /usr $SIZEVAR%  
EOF  
fi  
done
