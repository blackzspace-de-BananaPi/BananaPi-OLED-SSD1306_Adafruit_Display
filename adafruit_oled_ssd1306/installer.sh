#!/bin/bash
# installer.sh


# Author:    BlackLeakz
# Website:   https://blackzspace.de/
# Github:    https://github.com/blackzspace-de-BananaPi/BananaPi-OLED-SSD1306_Adafruit_Display
# Version:   0.1a
# Device:    Banana-Pi-M2-Berry
# Resources: BPI-M2-Berry, Adafruit OLED-SSD1306 - Display  && and a cup of coffee </3

# NFO: This device has the same GPIO-Pin-selection as Model B+ Raspberry Pi !!



echo -e " Console > At first you should enable i2c-devices by using the rasp-config or armbian-config !!"

echo -e "Console > For armbian-config navigate to System, the select Hardware and enable i2c2 & i2c3. REBOOT! "



me=$(whoami)
if [ "$me" != "root" ]; then
    echo "You must be root to do this."
    exit 1
fi

echo -e "Console > Installing now dependencies..."

if [ "apt-get install git python3-dev i2c-tools libffi-dev libssl-dev python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 libtiff5 git make cmake build-essential python3-dev python*pip -y" == "0" ]; then
    echo -e "Dependencies installed."
else
    echo -e "Dependencies not installed."
    echo -e "Console > Maybe it failed cuz of libtiff5, trying to fix problem by installing libtiff5-dev..."
    apt-get install libtiff5-dev i2c-tools -y
    apt install git python3-dev libffi-dev libssl-dev python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 git make cmake build-essential python3-dev python*pip -y
    exit 1
fi


echo -e "Console > Creating Virtual-Pip Env now!"

python3 -m venv ~/.env
source ~/.env/bin/activate


echo -e "Console > Trying to install pip requirements via req.txt file!!..."

echo -e "Console > This script stays sure, by redundance, installing pip requirements withput req.txt file to!!..."


pip3 install psutil
pip3 install Adafruit-BBIO
pip3 install Adafruit-SSD1306

sudo -H pip3 install luma.oled




mkdir ~/.tmp
cd ~/.tmp

git clone https://github.com/rm-hull/luma.oled.git
sudo chmod a+x -R ./*
$me=(whoami)
if [ "$me" != "root" ]; then
    sudo chown $me -hR /home/$me/tmp/luma*
    
fi
chown root -hR ~/**
cd ~/.tmp/luma*
python3 setup.py install


echo -e "Console > You should now be able to run one of the examples from the examples folder! (
if you have already connected the display correctly)"


echo -e "Console > Greetz & Have fun: Your BlackLeakz (by) blackzspace.de"


