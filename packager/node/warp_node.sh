#!/bin/sh

SYNTAX="Syntax : $0 node_version_without_v"

DIRNAME=`dirname $0`
RELATIVE_WARP_HOME=../../
. $DIRNAME/$RELATIVE_WARP_HOME/common/shell_lib.sh

load_lib node

if [ -f package.json ]; then
  i=0
  while [ $i -lt 4 ]
  do
  xterm &
  i=$[$i+1]
  done

  NODE_VERSION=`cat package.json | $WARP_HOME/common/json.sh | grep '\["engines","node"\]' | awk '{print $2}' | perl -pe 's/"//g'`
  if [ "${NODE_VERSION:0:1}" = "[" ]; then
    i=0
    NODE_VERSION=`cat package.json | $WARP_HOME/common/json.sh | grep "\[\"engines\",\"node\",$i\]" | awk '{print $2}' | perl -pe 's/"//g'`

    while [ "$NODE_VERSION" != "" ]
    do
      echo $NODE_VERSION > .node_version
      . $WARP_HOME/packager/node/node_package.sh

      i=$[$i+1]
      NODE_VERSION=`cat package.json | $WARP_HOME/common/json.sh | grep "\[\"engines\",\"node\",$i\]" | awk '{print $2}' | perl -pe 's/"//g'`
    done
  else
    echo "NO ARRAY"
    . $WARP_HOME/packager/node/node_package.sh
  fi
fi
