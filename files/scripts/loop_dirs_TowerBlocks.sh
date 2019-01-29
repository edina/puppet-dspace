#!/bin/bash

shopt -s extglob

countrydir="$PWD"

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
SCRIPTDIR="${SCRIPTDIR##*( )}"
DUBLIN_CORE_TEMPLATE="${SCRIPTDIR}/templates/dublin_core-TOWERBLOCKS.xml"

echo "SCRIPTDIR: ${SCRIPTDIR}"

# Don't loop through countries
# Loop through cities
for icity in `find . -maxdepth 1 -type d` ;
  do
	 # Ignore root folder of country
   if [[ "$icity" != "." ]]; then
	  echo "Next city is" "$icity"
	  cd "$icity"
	  # Make the contents file
	  source "${SCRIPTDIR}/make-TowerBlocks-contents.sh"
		cp "${DUBLIN_CORE_TEMPLATE}" dublin_core.xml
	  #pwd
	  # Go back to the country directory
	  cd "$countrydir"
   fi;
done

