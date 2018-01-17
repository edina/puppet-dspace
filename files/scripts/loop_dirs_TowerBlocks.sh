# Script to loop through Tower Blocks directories

#!/bin/bash


countrydir="$PWD"
# Don't loop through countries
    # Loop through cities
    for icity in `find . -maxdepth 1 -type d` ;
    do
	echo "Next city is" "$icity"
	cd "$icity"
	# Make the contents file
	~/wee_scripts/make-TowerBlocks-contents.sh
	#pwd
	# Go back to the country directory
	cd "$countrydir"
    done

