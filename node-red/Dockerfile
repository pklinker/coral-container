
#### Stage BASE ########################################################################################################
FROM coral-python:1 AS base

# Copy scripts
COPY scripts/*.sh /tmp/

# Install tools, create Node-RED app and data dir, add user and set rights
RUN set -ex &&  apt-get update && apt-get install -y \
        bash \
        tzdata \
        curl \
        nano \
        wget \
        git \
        openssl \
        openssh-client \
	apt-utils
#	software-properties-common
RUN mkdir -p /usr/src/node-red /data

RUN useradd --home-dir /usr/src/node-red --uid 1000 node-red && \
    chown -R node-red:root /data && chmod -R g+rwX /data && \ 
    chown -R node-red:root /usr/src/node-red && chmod -R g+rwX /usr/src/node-red

# Set work directory
WORKDIR /usr/src/node-red

# package.json contains Node-RED NPM module and node dependencies
COPY package.json .
COPY flows.json /data

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

#RUN add-apt-repository 'deb [trusted=yes] http://raspbian.raspberrypi.org/raspbian buster binary-armhf Packages'


RUN apt-get update
RUN apt-get install -y nodejs
#RUN apt-get install -y  python3-picamera

#### Stage BUILD #######################################################################################################
FROM base AS build

# Install Build tools
RUN apt-get update && apt-get install -y build-essential && \
    npm install --unsafe-perm --no-update-notifier --no-fund --only=production && \
    npm uninstall node-red-node-gpio && \
    cp -R node_modules prod_node_modules

#### Stage RELEASE #####################################################################################################
FROM base AS RELEASE
ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_REF
ARG NODE_RED_VERSION
ARG ARCH
ARG TAG_SUFFIX=default

LABEL org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile=".docker/Dockerfile.debian" \
    org.label-schema.license="Apache-2.0" \
    org.label-schema.name="Node-RED" \
    org.label-schema.version=${BUILD_VERSION} \
    org.label-schema.description="Low-code programming for event-driven applications." \
    org.label-schema.url="https://nodered.org" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/node-red/node-red-docker" \
    org.label-schema.arch=${ARCH} \
    authors="Dave Conway-Jones, Nick O'Leary, James Thomas, Raymond Mouthaan"

COPY --from=build /usr/src/node-red/prod_node_modules ./node_modules

# Chown, install devtools & Clean up
RUN chown -R node-red:root /usr/src/node-red && \
    apt-get update && apt-get install -y build-essential python-dev python3 && \
    rm -r /tmp/*

RUN apt-get install -y python3-gst-1.0 libgtk-3-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad python3-gi python-pip rpi.gpio

# need this to prevent ModuleNotFoundError: No module named 'PIL'
RUN pip3 install svgwrite setuptools

RUN export READTHEDOCS=True && \
    pip3 install picamera && \
    pip install picamera && \
    pip install -U RPi.GPIO

RUN npm install -g node-red-contrib-camerapi

ENV PATH="$PATH:/opt/vc/bin"

RUN echo "/opt/vc/lib" > /etc/ld.so.conf.d/00-vcms.conf


#USER node-red

# Env variables
ENV NODE_RED_VERSION=$NODE_RED_VERSION \
    NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules \
    FLOWS=flows.json

# ENV NODE_RED_ENABLE_SAFE_MODE=true    # Uncomment to enable safe start mode (flows not running)
# ENV NODE_RED_ENABLE_PROJECTS=true     # Uncomment to enable projects option


EXPOSE 1880

CMD ldconfig

ENTRYPOINT ["npm", "start", "--cache", "/data/.npm", "--", "--userDir", "/data"]