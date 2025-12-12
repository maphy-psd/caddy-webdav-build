# Stage 1: Build Caddy mit WebDAV-Plugin
FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

WORKDIR /build

ARG CADDY_VERSION=latest

RUN xcaddy build \
    --with github.com/mholt/caddy-webdav@latest \
    --version ${CADDY_VERSION}

# Stage 2: Runtime-Image
FROM caddy:2.8.4-alpine

COPY --from=builder /build/caddy /usr/bin/caddy

VOLUME ["/data", "/config"]
EXPOSE 80 443

ENTRYPOINT ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
