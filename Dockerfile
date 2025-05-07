ARG CADDY_VERSION=2
FROM caddy:${CADDY_VERSION}-builder AS builder

# RIP --with github.com/kirsch33/realip

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/plugin/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/ggicci/caddy-jwt \
    --with github.com/mholt/caddy-l4


FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
