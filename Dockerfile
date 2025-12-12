# Stage 1: Build Caddy mit WebDAV-Plugin
FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git ca-certificates
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

WORKDIR /build

ARG CADDY_VERSION=latest

RUN echo "Building Caddy version: ${CADDY_VERSION}" && \
    xcaddy build "${CADDY_VERSION}" \
      --with github.com/mholt/caddy-webdav@latest
