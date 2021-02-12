# Coral TPU Base Docker Container Image
In order to maximize reuse and simplify container image maintenance, I created a base image for Coral USB applications. It installs basic Linux packages, Python 3, Python edge TPU libraries, and the Linux edge TPU library.   

To build the Docker image use:
   
```docker build -t "coral-python:1" .```
   
Note: The subprojects that rely on this image, use version 1 in their Dockerfiles. If you change the version number of this image, change the dependent projects as necessary.   

This container doesn't do much at runtime. But if you want to run it, used privileged mode so it can access the USB edge device. Run it with:  
```docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb coral-usb:0.1 /bin/bash```