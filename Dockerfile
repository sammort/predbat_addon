FROM python:3.12.4-alpine3.20

# Set shell
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# RUN apt-get update
# RUN apt-get upgrade -y
# RUN apt-get dist-upgrade -y
# RUN apt-get install -y python3
# RUN apt-get install -y python3-pip
# RUN apt-get install -y python3-venv
# RUN apt-get install -y python3-requests
# RUN apt-get install -y python3-yaml
# #RUN apt-get install -y python3-asyncio
# RUN apt-get install -y python3-aiohttp
# RUN apt-get install csh
# RUN apt-get install -y python3-tz

RUN apk update && \
    apk upgrade && \
    apk add tcsh gcc

WORKDIR /config
COPY predbat/rootfs /config

COPY predbat/requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Start app
RUN chmod a+x run.csh

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="springfall2008 (https://github.com/springfall2008)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Springfall2008" \
    org.opencontainers.image.authors="springfall2008 (https://github.com/springfall2008)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/springfall2008" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

CMD [ "csh", "-f", "run.csh"]
