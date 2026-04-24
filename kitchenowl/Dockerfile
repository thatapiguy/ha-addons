ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

LABEL maintainer="vivekbavishi@gmail.com"
LABEL io.hass.version=${BUILD_VERSION}
LABEL io.hass.type="addon"
LABEL io.hass.arch="aarch64|amd64"

RUN sed -i 's/"wb", encoding="utf-8"/"wb"/' \
    /usr/src/kitchenowl/app/service/file_has_access_or_download.py

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8080
ENTRYPOINT ["/run.sh"]
