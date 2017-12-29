#!/bin/env bash

SAUER_DIRECTORY="~/Games/Sauerbraten"
DEMOS_DIRECTORY="./demos"
SAUER_EXECUTABLE="./demos_client"
SAUER_HOME="./config"
SAUER_OPTIONS="-q${SAUER_HOME}"
GAMESPEED="20000"
SCREENSHOT_DELAY="605000"

SN=1
NSN=2

echo "" > script.cfg
for DEMO in "$DEMOS_DIRECTORY"/*
do
    echo "demo_${SN} = [demo \"${DEMO%.dmo}\"; gamespeed $GAMESPEED; sleep $SCREENSHOT_DELAY [gamespeed 100; sleep 500 [screenshot \"../$(basename ${DEMO%.dmo})\"; demo_${NSN}]]]" >> script.cfg
    SN=${NSN}
    NSN=$(($NSN + 1))
done
echo "demo_${SN} = [quit]" >> script.cfg
echo "demo_1" >> script.cfg

cd $SAUER_DIRECTORY
$SAUER_EXECUTABLE $SAUER_OPTIONS -x"exec script.cfg"

if ! [ -x "$(command -v convert)" ]; then
    echo "Error: 'convert' not found. ImageMagick is required for converting images to jpg."
    exit 1
else
    cd $SAUER_HOME
    for i in *.png ; do convert "$i" "${i%.png}.jpg" ; done
    rm *.png
fi
