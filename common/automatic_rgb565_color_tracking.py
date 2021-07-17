# Automatic RGB565 Color Tracking Example
#
# This example shows off single color automatic RGB565 color tracking using the OpenMV Cam.

import sensor, image, time
print("Letting auto algorithms run. Don't put anything in front of the camera!")

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.skip_frames(time = 2000)
sensor.set_auto_gain(False) # must be turned off for color tracking
sensor.set_auto_whitebal(False) # must be turned off for color tracking
clock = time.clock()

# Capture the color thresholds for whatever was in the center of the image.
r = [(320//2)-(50//2), (240//2)-(50//2), 50, 50] # 50x50 center of QVGA.

print("Auto algorithms done. Hold the object you want to track in front of the camera in the box.")
print("MAKE SURE THE COLOR OF THE OBJECT YOU WANT TO TRACK IS FULLY ENCLOSED BY THE BOX!")
for i in range(60):
    img = sensor.snapshot()
    img.draw_rectangle(r)

print("Learning thresholds...")
threshold = [30, 70, -100, -20, 40, 100] # Middle L, A, B values.


print("Thresholds learned...")
print("Tracking colors...")

while(True):
    clock.tick()
    img = sensor.snapshot()
    for blob in img.find_blobs([threshold], pixels_threshold=10, area_threshold=10, merge=True, margin=10):
        img.draw_rectangle(blob.rect())
        img.draw_cross(blob.cx(), blob.cy())
        print(blob.cx(), blob.cy())
