#!/bin/bash
if [ $# -ne 1 ]; then
    echo Usage: `basename $0` filename 1>&2
    exit 1
fi
IFS="
"
lines=`sed "s/<[a-z]*/\n&/g" $1 |grep -E 'chatItem you|chatItem me|pre-wrap'`
author="none"
for line in $lines; do
    if echo $line |grep -q 'chatItem you'; then
        author="you"
    elif echo $line |grep -q 'chatItem me'; then
        author=" me"
    fi
    if echo $line |grep -q 'pre-wrap'; then
        word=`echo $line |grep -Po '>\K.*'`
        echo [$author] $word
    fi
done
