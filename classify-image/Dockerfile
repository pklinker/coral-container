FROM coral-python:1


RUN mkdir /coral
WORKDIR /coral
RUN git clone https://github.com/google-coral/tflite.git

WORKDIR /coral/tflite/python/examples/classification

RUN bash install_requirements.sh

EXPOSE 5005

