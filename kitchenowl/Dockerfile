ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

LABEL maintainer="vivekbavishi@gmail.com"
LABEL io.hass.version=${BUILD_VERSION}
LABEL io.hass.type="addon"
LABEL io.hass.arch="aarch64|amd64"

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8080
CMD ["/run.sh"]
