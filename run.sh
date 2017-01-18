#!/bin/bash

run_simulator () {
    sed -i.bak 's/,/ = /g' $1
    mkdir OUT_$1
    run_fred -p $1 -d OUT_$1
    sed -i.bak 's/ /,/g' OUT_$1/out1.txt
    python filter.py OUT_$1/out1.txt $2
    dos2unix $2 &> /dev/null
    rm $1.*
    rm -rf OUT_$1
}

# Set default parallel numbers
if [ -z "$3" ]
then
    parallel=4
else
    parallel=$3
fi
rm p_* y_*
# split input file
split -l3 $1 p_
NPROC=0
for i in $(ls p_*)
do
    echo "running simulator with $i"
    run_simulator $i ./y_$i > /dev/null &
    NPROC=$(($NPROC+1))
    if [ "$NPROC" -ge $parallel ]
    then
	wait
	NPROC=0
    fi
done
wait

cat y_* > $2
