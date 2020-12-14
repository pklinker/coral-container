#!/bin/sh
# runs node-red in docker
# privileged is needed to access camera deviced
docker run -it --privileged \
       --device /dev/vchiq \
       -p 1880:1880 \
       -v node_red_data:/data \
       -v /dev/bus/usb:/dev/bus/usb \
       -v /dev/vc:/dev/vc \
       -v /opt/vc/lib:/opt/vc/lib \
       -v /dev/video0:/dev/video0 \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v ${HOME}/.Xauthority:/home/user/.Xauthority \
       --env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/vc/lib:/lib:/usr/lib:/usr/local/lib \
       --name coralnodered \
       coral-nodered:1
