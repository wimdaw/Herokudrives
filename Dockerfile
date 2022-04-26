FROM redis:alpine

# Add glibc package
COPY ./glibc-2.35-r0.apk /lib/

# Add glibc key
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub

# Install glibc
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh
RUN apk add /lib/glibc-2.35-r0.apk
RUN apk update && apk add aria2
RUN mkdir -p /root/Downloads

# Set workdir
WORKDIR /root/cloudreve
ADD statics ./statics
ADD cloudreve ./cloudreve
# ADD cloudreve.db ./cloudreve.db
ADD run.sh ./run.sh

RUN chmod +x ./cloudreve
RUN chmod +x ./run.sh

CMD ./run.sh
