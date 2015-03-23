#!/bin/sh

words=$*
resText=$(dict "$words")
resCode=$?

case $resCode in
    0)
        xmessage "$resText" || true
        ;;
    20)
        ratpoison -c "echo No matches found for $words"
        ;;
    *)
        ratpoison -c "echo Error $resCode encountered. Consult dict man page."
        ;;
esac
