#!/bin/bash

PID=`jps -v | grep handle-server | awk '{print $1}' `
rv=0
if [ ! -z "$PID" ] ; then
    echo "killing $PID"
    rv=`kill $PID`
else
    echo "no server found"
fi

exit $rv
