#!/usr/bin/env bash
set -e

BUCKET=`cat /etc/objectivefs.env/BUCKET`
mount.objectivefs -o compact,compact ${BUCKET} /volume

trap 'killall --signal 1 --regexp mount.objectivefs' SIGHUP
echo "Started.  Pid=$$"

while :
do
   sleep 10 &
   wait
done