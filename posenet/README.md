# Run Coral PoseNet in a Container

This container runs the Google [Coral PoseNet](https://github.com/google-coral/project-posenet) in a Docker container. This container was run on a Raspberry Pi 4. To let the container access to the camera, a rule needs to be added to /etc/udev/rules.d/99-camera.rules:
   
```SUBSYSTEM=="vchiq",MODE="0666".```
   
See https://www.losant.com/blog/how-to-access-the-raspberry-pi-camera-in-docker for details on allowing Docker access to the camera.   

The pose analyzer also requires access to the x11 display. See 
http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/ for more information on allow Docker to access the display.   
   
To build this container image, you will need to have the [coral-python container](https://github.com/pklinker/coral-container/tree/main/coral-python) image. To build the PoseNet container use:
   
```docker build -t "coral-pose:0.1" .```

To run the container you need to allow the container to access the X server:   

```xhost +```   

Then run the container in privileged mode:   
```
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
Inside of the container run:
```
python3 pose_camera.py
```