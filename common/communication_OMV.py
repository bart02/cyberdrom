# Hello World Example
#
# Welcome to the OpenMV IDE! Click on the green run arrow button below to run the script!

from pyb import UART, LED

import sensor, lcd, image, time, utime

ledBlue = LED(2)
ledGreen = LED(3)

ledBlue.on()
sensor.reset()                      # Reset and initialize the sensor.
sensor.set_pixformat(sensor.RGB565) # Set pixel format to RGB565 (or GRAYSCALE)
sensor.set_framesize(sensor.LCD)   # Set frame size to QVGA (320x240)
sensor.skip_frames(100)     # Wait for settings take effect.
clock = time.clock()                # Create a clock object to track the FPS.
lcd.init()
#lcd.set_backlight(True)
ledBlue.off()

#Init uart

uart = UART(3)
uart.init(9600, bits=8, parity=None, stop=1, timeout_char=1000) # init with given parameters

a = 1
while(True):
   clock.tick()                    # Update the FPS clock.
   clk = utime.ticks_ms()
   a = a + 1
   uart.writechar(a)
   while (clk + 250 > utime.ticks_ms()):
       pass
