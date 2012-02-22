#!/bin/bash


TMPDIR=`mktemp -d /tmp/selfextract.XXXXXX`

echo ""
echo "This is a self extracting installer"
echo "Using temp directory $TMPDIR"
echo ""

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

tail -n+$ARCHIVE $0 | tar xzv -C $TMPDIR

CDIR=`pwd`

cd $TMPDIR
./install

cd $CDIR
rm -rf $TMPDIR

exit 0

__ARCHIVE_BELOW__
