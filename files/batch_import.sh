#!/bin/bash

email=
collection=
test=

while getopts c:e:t opt; do
  case $opt in
  c)
      collection=$OPTARG
      ;;
  e)
      email=$OPTARG
      ;;
  t)
      test="-t"
      ;;
  esac
done

shift $((OPTIND - 1))

if [ "$email" = '' -o "$collection" = '' ] ; then
    echo "syntax: `basename $0` -e <depositor_email> -c <collection_handle> [-t]"
    echo "-t: test run"
    echo
    echo "e.g:"
    echo "`basename $0` -e joe@bloggs.ed.ac.uk -c 10283/386"

    exit 1
fi

source=`pwd`

$DSPACE_HOME/bin/dspace ds-import --add --workflow --source=$source --mapfile=$source/mapfile.txt --eperson=$email --collection=$collection $test

exit $?
