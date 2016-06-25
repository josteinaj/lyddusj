#!/bin/bash

# update list of books
curl http://beta.nlb.no/titler/ | sed 's/.*href="//' | sed 's/".*//' | grep mp3 | sed 's/.mp3//' > /tmp/titler.txt
curl http://beta.nlb.no/baksidetekst/ | sed 's/.*href="//' | sed 's/".*//' | grep mp3 | sed 's/.mp3//' > /tmp/baksidetekst.txt
grep -Fx -f /tmp/titler.txt /tmp/baksidetekst.txt > /tmp/boknummer-alle.txt
cat /tmp/boknummer-alle.txt | grep -v "_" | grep "^6" > /tmp/boknummer.txt # only use books in the 6xxxxx series, and discard book "parts" (ids with underscore)
