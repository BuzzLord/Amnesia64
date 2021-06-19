#!/bin/bash

patch --version &> /dev/null
if [ $? != 0 ]; then
    >&2 echo "Patch not found, can not create tex2d shaders"
    exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd )"
SUBDIRS=$(find "$DIR" -maxdepth 1 -type d)
for d in $SUBDIRS; do
    pushd "$d" &> /dev/null
    echo
    pwd
    PATCHES=$(find . -maxdepth 1 -type f -name "*.patch")
    for p in $PATCHES; do
        iname=$(grep "^---" $p | head -1 | sed 's/^--- \([^\t]*\)\t.*/\1/')
        oname=$(grep "^+++" $p | head -1 | sed 's/^+++ \([^\t]*\)\t.*/\1/')
        if [ "$iname" == "" ]; then
            >&2 echo "Could not find input filename from $p"
            continue
        fi
        if [ "$oname" == "" ]; then
            >&2 echo "Could not find output filename from $p"
            continue
        fi
        if [ ! -f $iname ]; then
            >&2 echo "Could not find input file '$iname' for patch $p"
            continue
        fi
        patch -u -i $p -o $oname
    done

    popd &> /dev/null
done

