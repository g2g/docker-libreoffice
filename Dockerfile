# Inspired by Maik Ellerbrock

FROM debian:10-slim

# Optional Configuration Parameter
ARG SERVICE_USER
ARG SERVICE_HOME

# Default Settings
ENV SERVICE_USER ${SERVICE_USER:-office}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN \
  adduser --home ${SERVICE_HOME} --shell /sbin/nologin --uid 1000 --disabled-password --gecos "" ${SERVICE_USER} && \
  apt update && \
  mkdir -p /usr/share/man/man1 && \
  apt install -y \
    dumb-init \
    openjdk-11-jdk \
    libreoffice \
    libreoffice-base \
    libreoffice-java-common \
    libreoffice-l10n-fr \
    libgl1-mesa-glx \
    fonts-freefont-ttf

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "/usr/bin/libreoffice" ]
