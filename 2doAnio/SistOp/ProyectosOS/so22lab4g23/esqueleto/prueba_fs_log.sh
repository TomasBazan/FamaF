#!/bin/bash

i=0
cd mnt
while [[ $i -le 600 ]]; do
	echo "hola" >> test.txt
	cat test.txt
	j=(( $i % 100 ))
	if [[ j == 0 ]]; then 
		echo "$j"
		sleep 5
	fi
	i=((i+1))
done
