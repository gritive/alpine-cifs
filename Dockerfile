FROM alpine:3.19

# Install CIFS utilities and dependencies
RUN apk add --no-cache \
    cifs-utils \
    ca-certificates \
    tzdata \
    && rm -rf /var/cache/apk/*
