# Screenshot Tools
A small set of tools used for automatically taking screenshots from a group of demos.

## Requirements

If you wish to have the screenshots converted to jpg format, you must have ImageMagick installed on your system.

## Configuration
Make a copy of 'ss.sh' and open the copy in a text editor (to avoid merge conflicts when pulling from the repository). Change the following lines according to your need (in this context, CURRENT_DIRECTORY points to the directory where 'ss.sh' is located):

```
# Absolute path where the game is installed
SAUER_DIRECTORY="${HOME}/Games/Sauerbraten"

# Path to the directory containing the demos
DEMO_DIRECTORY="${CURRENT_DIRECTORY}/demos"

# Path where the screenshots should be saved
SCREENSHOT_DIRECTORY="${CURRENT_DIRECTORY}/screenshots"

# How long to wait before taking a screenshot
# 60500 = 1m 5s should work for most demos
# Change this if the demo has overtime
SCREENSHOT_DELAY="605000"
```

You may also change the following lines if necessary:

```
# Path where config files are located
SAUER_HOME="${CURRENT_DIRECTORY}/config"

# Path to the game's exectuable
SAUER_EXECUTABLE="${CURRENT_DIRECTORY}/demos_client"

# Add any options you want to start the game with here
SAUER_OPTIONS="-q${SAUER_HOME}"
```

## Running

Place your demos in DEMO_DIRECTORY, 'demos' by default, and run the following command:

```
./ss.sh
```

Once the game exists and the command finishes, screenshots can be found in SCREENSHOT_DIRECTORY, 'screenshots' by default.

## Notes
Only the source files that were altered from the original game (SVN rev. 4782) were included in this repository due to its size. If you wish to compile your own binary, you can use the included files as a patch.
