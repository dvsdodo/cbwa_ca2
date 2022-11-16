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

# Install the Ionic with npm
RUN npm install -g ionic

# Install NPM dependencies and devDependencies
RUN npm install

# Build App
RUN npm run build --prod

# Open server nginx and alpine to service
FROM nginx:alpine
# This tells Docker your webserver will listen on port 80 for TCP connections since TCP is the default. 
EXPOSE 80

RUN rm -rf /usr/share/nginx/html/*

# Create a user called static to secure running commands in the image build and container runtime processes
#USER static

# Copy app files into /usr/share/nginx/html
COPY --from=build /app/mobdev_ca3-main/www/ /usr/share/nginx/html/
