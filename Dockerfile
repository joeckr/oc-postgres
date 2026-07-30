ARG VERSION=18
ARG REGISTRY=docker.io/library
FROM $REGISTRY/postgres:$VERSION-alpine

ENV PGDATA=/tmp/data

RUN mkdir -p /tmp/data && \
    chgrp -R 0 /tmp && \
    chmod -R g+rwX /tmp
