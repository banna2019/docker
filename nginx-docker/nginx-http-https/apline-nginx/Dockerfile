FROM nginx:1.17.3-alpine

RUN apk add --no-cache bash gawk sed grep bc coreutils \
    && mkdir -pv /etc/pki/tls/ 
COPY ca.crt /etc/pki/tls/ca.crt
COPY server.key /etc/pki/tls/server.key
RUN chmod 0600 /etc/pki/tls/ca.crt \
    && chmod 0600 /etc/pki/tls/server.key

ADD nginx.conf.template /
ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["/bin/bash","/entrypoint.sh"]
