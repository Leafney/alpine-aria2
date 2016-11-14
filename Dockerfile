FROM alpine:latest
MAINTAINER leafney "babycoolzx@126.com"

RUN apk add --no-cache aria2 \
	&& adduser -D aria2 \
	&& mkdir -p /etc/aria2 \
	&& mkdir -p /aria2down \
	&& rm -rf /var/lib/apk/lists/*

# gosu version
ENV GOSU_VERSION 1.10

# gosu install latest
RUN aria2c https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64 -o /usr/local/bin/gosu \
	&& chmod +x /usr/local/bin/gosu

# aria2.session
RUN touch /etc/aria2/aria2.session

COPY aria2.conf /etc/aria2/aria2.conf

VOLUME /aria2down

RUN chown -R aria2:aria2 /aria2down \
	&& chown -R aria2:aria2 /etc/aria2

EXPOSE 6800

CMD ["gosu","aria2","aria2c", "--conf-path=/etc/aria2/aria2.conf"]