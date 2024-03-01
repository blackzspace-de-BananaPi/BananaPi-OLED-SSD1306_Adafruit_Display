

[Name]    --  [BananaPi] || [Adafruit OLED SSD1306-Display] || [Controlling GPIO-PIN's]  by using [Python3] 
[LIBARYS] --  [luma.oled] [Adafruit-SSD1306] [Adafruit-BBIO] [psutil]
[Author]  --  [BlackLeakz]
[Website] --  ['https://blackzspace.de'] (blackzspace.de)
[Github]  --  ['https://github.com/blackleakz/BPI-M2-Berry_ssd1306-oled-control.git'] (URL)
[Version] --   0.1a





[ ] - For an automatical-Install , just chmod a+x installer.sh and run : 

```sh
sudo ./installer.sh  
```

[ ] - But dont forget to activate i2c in raspi-config / armbian-config !!!
    
    Turn on i2c!!! I'd prefere to activate spi-dev's too!

  --  for Raspian OS:

    ```sh
      sudo raspi-config
      sudo reboot
  ```

  -- for Armbian:
  
    ```sh
      sudo armbian-config
      select Hardware
      enable i2c2
      enable i2c3
      sudo reboot
    ```   


[ ] - The auto-install script should usually set the User to the necessary system-Role-Groups: i2c, spi & gpio !
      If NOT, JUST ENTER FOLLOWIN COMMAND!


  ```sh
  me=$(whoami)
  sudo gpasswd -a $me gpio i2c spi
  ```

  Here you'll learn,  how to deal with an Adafruit OLED SSD1306 Display on you BananaPi Board by controling the GPIO-Pins !


  (In my case, im using a Banana Pi M2 Berry which GPIO-Pins match with the Model Raspberry Pi 3  !)

[ ] - GPIO-PIN Settings for the ssd1306 oled display: Connect your GPIO-PINS like that.

```
 PIN-NUMBER: 1 | CON1-P01 (GPIO Pin Name) |  VCC-3V3 (Default Function)    
 PIN-NUMBER: 3 | CON1-P03 (GPIO Pin Name) |  TWI2-SDA (Default Function)
 PIN-NUMBER: 5 | CON1-P05 (GPIO Pin Name) |  TWI2-SCK	(Default Function)     
 PIN-NUMBER: 9 | CON1-P09 (GPIO Pin Name) |  GND (Default Function)

```

[ ] - Install requirements:


(Debian/Ubuntu)
```sh
sudo apt-get install -y i2c-tools;
sudo apt-get install python3-dev libffi-dev libssl-dev python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 libtiff5* -y;
```
((Maybe you need to change libtiff5 to libtiff5-dev!!!))


[NOTE] - On current systems, you maybe need to create e virtual-Enviroment! To BYPASS this, you can install the Packages Globaly (SYSTEM-WIDE)
by FORCING THE PARAMETER:


```sh
python3 -m pip install Adafruit-SSD1306 Adafruit-BBIO psutil --break-system-packages
```

[OTHERWISE] - Create VENV!

```sh
python3 -m venv .env
source .env/bin/activate
```
[ESSENTIAL] - Installing necessary pip-Libarys:

```sh
python3 -m pip install -U pip
python3 -m pip install --upgrade pip wheel setuptools disutils
```

[Important] -  Libarys:
```sh
python3 -m pip install Adafruit-SSD1306 Adafruit-BBIO psutil luma-oled
```

[ ] - OR by:

```sh
pip3 install psutil
pip3 install Adafruit-BBIO
pip3 install Adafruit-SSD1306

sudo -H pip3 install luma.oled
```

[NOTE] - You can install downloaded libarys by using:

```sh
cd /path/to/libarys/setup.py
pip3 install .

```
  INSTEAD OF:

```sh
python3 setup.py install
```





[SETP] - Now, try to scan for connected i2c-tools:
[ATTENTION] - The Detection works only by using the right parametes for BUS & PORT, depending on your Hardware/Board !!

- In my case, I use this Command on [BananaPi-M2Berry]


```sh
    i2cdetect -y -r 2
  ```

 [LOOK] - the ouput should be like this:

```
0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- 3c -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
```


[GOT] - That shows the current i2c-devices matrix,  the i2c-address is = 0x3C, port = 2

[IMPORT] - To control the oled display, run python3 and import the libary luma.oled as shown below:

```sh
from luma.core.interface.serial import i2c
from luma.core.render import canvas
from luma.oled.device import ssd1306
```


[STEP] -  After including the libarys you need to define the device you wanna use band initializ a serial-communication with followin parameters: 

# PORT [2] -  ADDRESS [0x3C]


[NOTE] - In python code you need to initializ the i2c-device by using the parameters the command i2cdetect, outputed before


```sh
serial = i2c(port=2, address=0x3C)
device = ssd1306(serial)
```

[STEP] - Then you can call the modules.draw function by writin:

```sh
with canvas(device) as draw:
    draw.rectangle(device.bounding_box, outline="white", fill="black")
    draw.text((30, 40), "Hello World", fill="white")
```


# Usefull links:

['https://wiki.banana-pi.org/Banana_Pi_BPI-M2_Berry#Image_Release'] (Datasheet)
['https://github.com/rm-hull/luma.oled']  (LUMA.OLED)

# BananaPi GPIO Control Adafruit OLED SSD1306
