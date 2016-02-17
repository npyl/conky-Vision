#! /bin/bash

#======================================
#   ANSI colors
#======================================
ansi_reset='\e[0m'
blue='\e[34m'
yellow_b='\e[1;33m'
red_b='\e[1;31m'


#======================================
#   Global Variables
#======================================
INKSCAPE="/usr/bin/inkscape"
SOURCE="SVG/*.svg"
PNG_DEST=".conky-vision-icons"
DEFAULT_COLOR="#000000"


#======================================
#   User Input
#======================================
echo "Enter icon size (skip for default icon dimensions): "
read -r SIZE
echo "Enter 1 or more colors (space or tab separated): "
read -r -a ICON_COLORS


# If no colors given, add default color to array
if [ ${#ICON_COLORS[*]} -eq 0 ]; then
    ICON_COLORS[0]="$DEFAULT_COLOR"
fi


#======================================
#   RENDER
#======================================

# Loop over colors
for color in ${ICON_COLORS[*]}; do

    # Check  whether the png folder already exits
    if [ -d "$PNG_DEST/$color" ]; then
        echo -e ${red_b}"$SOURCE/$color already exists!${ansi_reset}"
        exit 0
    fi


    # Create dir with color name
    mkdir -p "$color"


    # Trap sed
    trap 'sed -i "s/<path fill=\"$color\"/<path/" $SOURCE; exit' INT TERM


    # Temporarily edit svg's
    sed -i "s/<path/<path fill=\"$color\"/" $SOURCE


    # Loop through SVG folder & render png's
    for i in $SOURCE; do
        i2=${i##*/}  i2=${i2%.*}

        if [ -f "$color/$i2.png" ]; then
            echo -e "${red_b}$color/$i2.png exists.${ansi_reset}"
        else
            echo
            echo -e "${blue}Rendering ${yellow_b}$color/$i2.png${ansi_reset}"
            "$INKSCAPE"  -e "$color/$i2.png" "$i" > /dev/null \
                         ${SIZE:+--export-width="$SIZE" --export-height="$SIZE"}
        fi
    done


    # Inkscape doesn't work well with dir paths
    # Move folder manually
    mv "$color" "$PNG_DEST"


    # Revert edit of svg's before next iteration or EXIT
    sed -i "s/<path fill=\"$color\"/<path/" $SOURCE

done
exit 0
