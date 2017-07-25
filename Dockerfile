FROM alpine:3.5
MAINTAINER Paul Michali <pcm@cisco.com>


RUN apk add --update curl && apk add --update tar

COPY v6bridge-install.sh /

ENTRYPOINT ["/v6bridge-install.sh"]
