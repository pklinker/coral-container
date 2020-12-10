Create a Coral Pose Net container.

This was run on a Raspberry Pi 4. To let container access to the camera, I added a rule to /etc/udev/rules.d/99-camera.rules: SUBSYSTEM=="vchiq",MODE="0666". See https://www.losant.com/blog/how-to-access-the-raspberry-pi-camera-in-docker for details.

The pose analyzer also requires access to the 11 display. See 
http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/   
   


To build the container use:
```docker build -t "coral-pose:0.1" .```

Running the container:
```xhost +
docker run -it --privileged \
       --device /dev/vchiq \
       -e DISPLAY=$DISPLAY \
       -v /dev/bus/usb:/dev/bus/usb \
       -v /dev/vc:/dev/vc \
       -v /dev/video0:/dev/video0 \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v ${HOME}/.Xauthority:/home/user/.Xauthority \
       --net=host \
       --env LD_LIBRARY_PATH=/opt/vc/lib:/lib:/usr/lib:/usr/local/lib \
       coral-pose:0.1 \
       /bin/bash```
