FROM coral-python:1


RUN mkdir /coral
WORKDIR /coral
RUN git clone https://github.com/google-coral/tflite.git

WORKDIR /coral/tflite/python/examples/classification

RUN bash install_requirements.sh

EXPOSE 5005

CMD ["python3 classify_image.py \
--model models/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite \
--labels models/inat_bird_labels.txt \
--input images/parrot.jpg"]
