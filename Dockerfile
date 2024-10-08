FROM ubuntu:22.04

USER root
WORKDIR /tmp

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y zsh curl git sudo

ARG USER_UID=1000
ARG USER_GID=1000

RUN \
  useradd --shell /bin/bash --user-group --create-home appuser && \
  usermod --non-unique --uid ${USER_UID} appuser && \
  groupmod --non-unique --gid ${USER_GID} appuser

WORKDIR /home/appuser
USER appuser
