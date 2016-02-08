#Attention
This conky won't work until I find a suitable weather provider. See [this issue](https://github.com/zagortenay333/Harmattan/issues/12).

---

###Vision :sunny: :umbrella: :cloud: :snowflake: :snowman:

A theme for [conky](https://github.com/brndnmtthws/conky) version `1.9.x`.

It displays the **time**, **date**, **current** **weather**, and **forecast** for the next 4 days.

---

###Installation

* Install **conky** and **curl**.

* Install the [Poiret One](https://www.google.com/fonts/specimen/Poiret+One) font.

* Move the `.conky-vision-icons` folder and `.conkyrc` file into your `~` dir.

**NOTE** some files/folders are hidden; unhide them. :smile:

---

###City

To change the city, edit the **WOEID** in the `template7` variable in the `.conkyrc` file.

---

###Language

By default this conky will use your locale.

If you want to use a different language without changing your locale settings, edit the `template9` variable in the `.conkyrc` file.

---

###Colors

* **Text** colors can be edited in the `.conkyrc` file.

* To change the **icon** colors, first use the `render-pngs.sh` script to render a folder of icons with the desired color, then change the icon sources in the `.conkyrc` file under the `Icon Sources` section.
    * The script uses the `SVG` folder to render png's.

    * Keep the size at **32(px)** for this conky.

---

###Temperature Unit

To change the temp unit, edit the `template8` variable inside the `.conkyrc` file.

---

![preview](preview.png)
