FROM coral-python:1


# Install the camera libraries

RUN apt install -y python3-gst-1.0 libgtk-3-dev gstreamer1.0-plugins-good  gstreamer1.0-plugins-bad python3-gi

# need this to prevent ModuleNotFoundError: No module named 'PIL'
 
RUN mkdir /coral
WORKDIR /coral
RUN git clone https://github.com/google-coral/project-posenet.git
WORKDIR /coral/project-posenet

RUN pip3 install svgwrite

ENV DISPLAY :0

#EXPOSE 5005

CMD ["python3 simple_pose.py"]
