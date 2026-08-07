# syntax=docker/dockerfile:1

ARG CADDY_VERSION
ARG WEBDAV_VERSION

FROM caddy:${CADDY_VERSION}-builder AS builder

ARG WEBDAV_VERSION
RUN xcaddy build --with github.com/mholt/caddy-webdav@${WEBDAV_VERSION}

FROM caddy:${CADDY_VERSION}-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

VOLUME ["/data", "/config"]
EXPOSE 80 443

ENTRYPOINT ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
