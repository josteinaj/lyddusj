#!/bin/bash

if [ "$JINGLE" != "1" ]; then
    JINGLE="0"
fi

if [ "`ps aux | grep -v grep | grep /tmp/audio.mp3 | wc -l`" = "1" ]; then
    echo "already playing"
    exit
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -e /tmp/boknummer.txt ]; then
    $DIR/update-list.sh
fi

while [ 1 ]; do
    BOOK_ID="`sort /tmp/boknummer.txt -R | head -n 1`"
    if [ "$BOOK_ID" = "" ]; then
        echo "empty book id"
        exit
    fi
    
    wget http://beta.nlb.no/titler/$BOOK_ID.mp3 -O /tmp/audio.mp3
    play /tmp/audio.mp3
    sleep 2
    wget http://beta.nlb.no/baksidetekst/$BOOK_ID.mp3 -O /tmp/audio.mp3
    play /tmp/audio.mp3
    if [ "$JINGLE" = "1" ]; then
        play "$DIR/NLB.mp3"
    fi
    sleep 10
done
