FROM nginx:1.21.3

RUN apt-get update -qq && apt-get -y install apache2-utils openssl

ENV RAILS_ROOT /var/www/archangel
ENV CERTIFICATE_DIR $RAILS_ROOT/certs
ENV CERTIFICATE_ORGANIZATION Archangel
ENV CERTIFICATE_COUNTRY US
ENV CERTIFICATE_STATE Texas
ENV CERTIFICATE_DOMAIN *.archangel.io

WORKDIR $RAILS_ROOT

RUN mkdir -p log
RUN mkdir -p $CERTIFICATE_DIR

COPY public public/
COPY docker/web/nginx.conf /tmp/docker.nginx

RUN openssl req -new \
  -x509 -nodes -days 365 \
  -subj "/CN=${CERTIFICATE_DOMAIN}/O=${CERTIFICATE_ORGANIZATION}/C=${CERTIFICATE_COUNTRY}/ST=${CERTIFICATE_STATE}" \
  -keyout ${CERTIFICATE_DIR}/server.key \
  -out "${CERTIFICATE_DIR}/server.crt"

RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD [ "nginx", "-g", "daemon off;" ]
