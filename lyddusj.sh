#!/bin/bash

if [ "$JINGLE" != "1" ]; then
    JINGLE="0"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FFMPEG=`command -v avconv || command -v ffmpeg`

if [ ! -e /tmp/boknummer.txt ]; then
    $DIR/update-list.sh
fi

while [ 1 ]; do
    BOOK_ID="`sort /tmp/boknummer.txt -R | head -n 1`"
    if [ "$BOOK_ID" = "" ]; then
        echo "empty book id"
        exit
    fi
    
    amixer set "Stereo Master" 10%
    
    wget http://beta.nlb.no/titler/$BOOK_ID.mp3 -O /tmp/tittel.mp3
    wget http://beta.nlb.no/baksidetekst/$BOOK_ID.mp3 -O /tmp/baksidetekst.mp3
    #"$FFMPEG" -i /tmp/tittel.mp3 -y /tmp/tittel.wav
    #"$FFMPEG" -i /tmp/baksidetekst.mp3 -y /tmp/baksidetekst.wav
    play /tmp/tittel.mp3
    sleep 2
    play /tmp/baksidetekst.mp3
    if [ "$JINGLE" = "1" ]; then
        play "$DIR/NLB.mp3"
    fi
    sleep 10
done
