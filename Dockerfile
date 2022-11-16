# Add a line in Dockerfile with base image
# syntax=docker/dockerfile:1
FROM node as build

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
# Create a working directory.
WORKDIR /app

# Download CA3 app from GitHub
RUN wget https://github.com/dvsdodo/mobdev_ca3/archive/main.tar.gz \
&& tar xf main.tar.gz \
&& rm main.tar.gz

# Change workdir
WORKDIR /app/mobdev_ca3-main/

