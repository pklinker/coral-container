xhost +
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
       /bin/bash
