#!/bin/bash

loops=3000
# This checks if there is already an output file, if there is, it backs it up
if [ -e woutput ]; then
    mv woutput woutput.backup
fi
if [ -e loutput ]; then
    mv loutput loutput.backup
fi

# This runs the program loops amount of times, one for the person changing, and one for the person staying. I used seq as it let me use loops, otherwise I would have had to put the number in
for counter in $(seq 1 $loops)
do
    ./game < winput >> woutput
    ./game < linput >> loutput
done
 
# grep -c counts how many instances of the line there are in the file
echo "Times won by switching: $(grep -c "You win the car" woutput)/$loops"
echo "Times won by not switching: $(grep -c "You win the car" loutput)/$loops"
