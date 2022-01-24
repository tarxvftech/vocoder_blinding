#!/bin/bash

PLAY="play -r 8k -c 1 -b 16 -L -t s16"
numfiles=${#@} 
maxi=$(( numfiles - 1 ))
iterations=$((numfiles * 5))

PICK="shuf -i 0-$maxi -n 1" # -i is range, -n is number of samples of shuffled list
scores=()
for i in $(seq 0 $maxi); do
	scores+=(0)
done

for i in $(seq 0 $iterations); do 
	idx=$($PICK)
	argvidx=$(( $idx + 1 )) #because $0 is the program name...
	echo "Playing a file:"
	#echo $idx, $argvidx, ${!argvidx}
	$PLAY -q "${!argvidx}"  # ! is indirection so if idx == 1, then !idx == $1
	echo -ne "Done playing. Provide a score: "; read -r score
	scores[$idx]=$(( ${scores[$idx]} + $score ))
done
echo "Unblinding:"
for i in $(seq 0 $maxi); do
	argvidx=$(( $i + 1 )) #because $0 is the program name...
	file="${!argvidx}"
	echo "File $i, Score ${scores[$i]}: $file"
done
#for file in ${@}; do
	#echo "File $i: $file"
	#i=$((i+1))
#done

