FROM coral-python:1

# Install the camera libraries

RUN apt-get update && apt-get install -y python3-gst-1.0 libgtk-3-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad python3-gi python3-pycoral

# need this to prevent ModuleNotFoundError: No module named 'PIL'
 
RUN mkdir /coral
WORKDIR /coral
RUN git clone https://github.com/google-coral/project-posenet.git

#Posenet ARM library is in armv7a, may not match you architecture
WORKDIR /coral/project-posenet/posenet_lib
RUN mkdir `uname -m` && \
    cd `uname -m` && \
    ln -s ../armv7a/posenet_decoder.so posenet_decoder.so

RUN pip3 install svgwrite

WORKDIR /coral/project-posenet

ENV DISPLAY :0

#EXPOSE 5005

CMD ["python3 simple_pose.py"]
