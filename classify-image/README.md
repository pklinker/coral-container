# Coral TPU Image Classifer Container

Run the Google Coral TPU image classifier in a Docker container.

To build this container image, you will need to have the coral-python container image. You can find this container's Dockerfile at <https://github.com/pklinker/coral-container/tree/main/coral-python>.   

To build the classifier image, run:      
```docker build -t "coral-classify:0.1" .```   
  
After building the image, you can run it using:   
```docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb coral-classify:0.1 /bin/bash```   
Note that it has to be run as privileged in order to access the USB connected Coral TPU accelerator.   

After starting the container you can run the classifier as follows:   
```
python3 classify_image.py \
--model models/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite \
--labels models/inat_bird_labels.txt \
--input images/parrot.jpg