#!/bin/env bash


# Should point to the directory containing this script
CURRENT_DIRECTORY=`pwd`


# Absolute path where the game is installed
SAUER_DIRECTORY="${HOME}/Games/Sauerbraten"

# Path to the directory containing the demos
DEMO_DIRECTORY="${CURRENT_DIRECTORY}/demos"

# Path where the screenshots should be saved
SCREENSHOT_DIRECTORY="${CURRENT_DIRECTORY}/screenshots"


# Path where config files are located
SAUER_HOME="${CURRENT_DIRECTORY}/config"

# Path to the game's exectuable
SAUER_EXECUTABLE="${CURRENT_DIRECTORY}/demos_client"

# Add any options you want to start the game with here
SAUER_OPTIONS="-q${SAUER_HOME}"


GAMESPEED="20000"

# Write the script which plays the demos and takes screenshots
#
# The way this works is as follows:
# - Write an empty script.cfg in SAUER_HOME
# - For each file in DEMO_DIRECTORY:
#    - Create a new, numbered alias which starts the demo, waits
#      until it's over, takes a screenshot, and runs the alias
#      whose number is 1 higher
# - Write one more alias whose number follows the last one we
#   wrote, which exists from the game
# - Add the name of the first alias to have it executed
#
# This creates a chain, which takes screenshots for all demos in
# a single run and then exits. This approach is better and faster
# than restarting the game after every screenshot
SN=1
NSN=2
echo "" > "${SAUER_HOME}/script.cfg"
for DEMO in "$DEMO_DIRECTORY"/*
do
    echo "demo_${SN} = [demo \"${DEMO%.dmo}\"; gamespeed $GAMESPEED; sleep 100000 [scoreboard 1]; intermission = [gamespeed 100; sleep 2000 [screenshot \"${SCREENSHOT_DIRECTORY}/$(basename ${DEMO%.dmo})\"; demo_${NSN}]]]" >> "${SAUER_HOME}/script.cfg"
    SN=${NSN}
    NSN=$(($NSN + 1))
done
echo "demo_${SN} = [quit]" >> "${SAUER_HOME}/script.cfg"
echo "demo_1" >> "${SAUER_HOME}/script.cfg"

# Launch the game and execute our script
cd $SAUER_DIRECTORY
$SAUER_EXECUTABLE $SAUER_OPTIONS -x"exec script.cfg"

# Check if convert exists
if ! [ -x "$(command -v convert)" ]; then
    echo "Error: 'convert' not found. ImageMagick is required for converting images to jpg."
    exit 1
else
    # Preserve relative paths
    cd $CURRENT_DIRECTORY
    cd $SAUER_HOME
    cd $SCREENSHOT_DIRECTORY
    
    # Convert all pngs to jpgs
    for i in *.png ; do convert "$i" "${i%.png}.jpg" ; done
    
    # Remove all pngs
    rm *.png
fi
