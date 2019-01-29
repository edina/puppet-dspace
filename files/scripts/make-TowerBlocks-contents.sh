## Script to create a contents file
## and a readme.txt containing a file listing
## in preparation for batch import

#!/bin/bash

## Initialise readme file ##
echo "# File listing #  " > readme.txt
printf "\r\n" >> readme.txt

# Text specific to Tower Blocks readme file
echo "In most cases the filename indicates the street and building. Where multiple photographs were taken at the same location, they may have the same filename; they are distinguished by a number in brackets at the end of the filename (the numbers in parentheses were added automatically by the Windows operating system). " >> readme.txt
printf "\r\n\r\n" >> readme.txt

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
	    if [[ $f =~ ^ignore|^Thumbs|^exclude ]] ; then
		    echo "Ignoring " $f
		else
		    echo "working on: " $f
		    printf "$f \r\n" >> readme.txt
		    echo "$f" >> contents

		fi; # if is labelled 'ignore' or 'exclude' or is 'Thumbs' thumbnail file
	  fi; # if is not contents
    fi; # if is not dublin_core file
  fi; # file exists

done