ARG VERSION=18
FROM postgres:$VERSION-alpine

ENV PGDATA=/tmp/data

RUN addgroup postgresadmingroup
RUN adduser -H -D postgresadmin
RUN chown -R postgresadmin:postgresadmingroup /tmp
RUN chmod -R 755 /tmp
USER postgresadmin
