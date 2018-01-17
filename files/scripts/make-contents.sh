## Script to create a contents file
## and a readme.txt containing a file listing
## in preparation for batch import

#!/bin/bash

## Initialise readme file ##
echo "# File listing #" > readme.txt

echo "" >> readme.txt

## Initialise contents file ##
echo "" > contents


if [ -f "dublin_core.xml~" ] ; then 
    rm dublin_core.xml~
fi;
if [ -f "contents~" ]; then
rm contents~
fi;

for f in *; do

    if [ -f "$f" ]; then # if file exists
	if  [[ $f != "dublin_core.xml" ]] ; then
	    if [[ $f != "contents" ]] ; then
		shopt -s nocasematch
	        if [[ $f =~ ^ignore ]] ; then
		    echo "Ignoring " $f
		else 
		    echo "working on: " $f
		    echo $f >> readme.txt
		    echo $f >> contents

		fi; # if is labelled 'ignore'
	    fi; # if is not contents
	fi; # if is not dublin_core file
    fi; # file exists

done 


