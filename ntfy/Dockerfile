#============================#
#  NTFY DOCKERFILE  #
#============================#
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required packages
RUN \
    apk add --no-cache \
        ca-certificates \
        curl \
        jq \
        tzdata

# Install ntfy binary
RUN \
    ARCH=$(uname -m) && \
    case $ARCH in \
        x86_64) NTFY_ARCH="amd64" ;; \
        aarch64) NTFY_ARCH="arm64" ;; \
        armv7l) NTFY_ARCH="armv7" ;; \
        armv6l) NTFY_ARCH="armv6" ;; \
        i386) NTFY_ARCH="386" ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    NTFY_VERSION="2.12.0" && \
    curl -fsSL "https://github.com/binwiederhier/ntfy/releases/download/v${NTFY_VERSION}/ntfy_${NTFY_VERSION}_linux_${NTFY_ARCH}.tar.gz" | \
    tar -xzC /tmp && \
    find /tmp -name "ntfy" -type f -executable -exec mv {} /usr/bin/ntfy \; && \
    chmod +x /usr/bin/ntfy && \
    rm -rf /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="thatapiguy (https://github.com/thatapiguy)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="thatapiguy (https://github.com/thatapiguy)" \
    org.opencontainers.image.licenses="Apache 2.0" \
    org.opencontainers.image.url="https://github.com/thatapiguy" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
