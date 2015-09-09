#! /bin/bash

#======================================
#   Global Variables
#======================================
INKSCAPE="/usr/bin/inkscape"
SOURCE="SVG/*.svg"
DEFAULT_COLOR="#000000"


#======================================
#   User Input
#======================================
echo "Enter icon size (this is the width and height): "
read SIZE
echo "Enter 1 or more colors (space or tab separated): "
read -a ICON_COLORS

# If no colors given, add default color to array
if [ ${#ICON_COLORS[*]} -eq 0 ]; then
    ICON_COLORS[0]=$DEFAULT_COLOR
fi


#======================================
#   Loop through icon colors
#======================================
for color in ${ICON_COLORS[*]}; do

# Create dir with color name
    mkdir -p $color


# Trap sed
    trap "sed -i 's/<path fill=\"$color\"/<path/' $SOURCE; exit" INT TERM


# Temporarily edit svg's
    sed -i "s/<path/<path fill=\"$color\"/" $SOURCE


# Loop through SVG folder & render png's
    for i in SVG/*.svg
    do
        i2=${i##*/}  i2=${i2%.*}

        if [ -f $color/$i2.png ]; then
                echo $color/$i2.png exists.
        else
            echo
            echo Rendering $color/$i2.png
            $INKSCAPE --export-width=$SIZE \
                      --export-height=$SIZE \
                      --export-png=$color/$i2.png $i >/dev/null
        fi
    done


# Revert edit of svg's before next iteration or EXIT
    sed -i "s/<path fill=\"$color\"/<path/" $SOURCE

done
exit 0
