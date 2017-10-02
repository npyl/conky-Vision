#!/bin/bash

cp -r .conky-vision-icons ~/
mkdir -p ~/.cache/conky-vision

read -p 'Enter your OpenWeatherMap API key: ' API_KEY
if [ -z "$API_KEY" ]
then

  read -p 'Enter your locale (leave empty for default): ' LOCALE
  sed "s/template9=\"\"/template9=\"$LOCALE\"/" .conkyrc-noweather > ~/.conkyrc

else
  sed "s/template6=\"\"/template6=\"$API_KEY\"/" .conkyrc > .conkyrc-tmp

  read -p 'Enter your city id: ' CITY_ID
  sed -i "s/template7=\"\"/template7=\"$CITY_ID\"/" .conkyrc-tmp

  read -p 'Enter your unit system (default, metric, imperial): ' UNIT_SYSTEM
  sed -i "s/template8=\"\"/template8=\"$UNIT_SYSTEM\"/" .conkyrc-tmp

  read -p 'Enter your locale (leave empty for default): ' LOCALE
  sed "s/template9=\"\"/template9=\"$LOCALE\"/" .conkyrc-tmp > ~/.conkyrc

  rm .conkyrc-tmp
fi

echo 'Installation complete.'
