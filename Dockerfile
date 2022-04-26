FROM alpine:latest

# Update apline system 
RUN apk update

# Install aria2 package
RUN apk add aria2

# COPY glibc package
COPY ./glibc-2.35-r0.apk /lib/

# Download glibc key
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub

# Install glibc
RUN apk add /lib/glibc-2.35-r0.apk

# COPY aria2 profile
COPY ./aria2.conf /root/aria2/aria2.conf

# COPY trackers profile
COPY ./trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh

# Create aria2 download directory
RUN mkdir -p /root/Downloads

# Download DHT profile
RUN wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat

# Download DHT6 profile
RUN wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat

# Create aria2 log file
RUN touch /root/aria2/aria2.session /root/aria2/aria2.log

# Set workdir
WORKDIR /root/cloudreve

# Add static css file
ADD statics ./statics

# Add cloudreve installation package
ADD cloudreve ./cloudreve

# Add run script
ADD run.sh ./run.sh

# Give cloudreve installation package 755 permission
RUN chmod +x ./cloudreve

# Give run script 755 permission
RUN chmod +x ./run.sh

# Run startup script
CMD ./run.sh
