#!/bin/sh

if [ $# -eq 0 ]; then
  echo "usage: heal.sh 1.1.1.1 ~/dir execcommand url" && exit 1
fi

MASTERIP=$1
DIR=$2
CMD=$3
URL=$4

rsync -avz root@$MASTERIP:$DIR .

if [ "$?" -ne "0" ]; then
  echo "Server down"
  $CMD
  exit 1
fi

if curl -s -I $URL | grep "200 OK"; then
   echo ""
else
   echo "$URL is DOWN"
   $CMD
fi