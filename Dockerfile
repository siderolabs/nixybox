FROM ghcr.io/siderolabs/stagex/core-busybox:2026.06.0@sha256:d5635b945c50a0170bea2900141665707c196eacfe2d7c34cf1254c81c1a5cef AS busybox

FROM scratch AS build
COPY --from=busybox / /
RUN mkdir -p /out/nix/var/nix/profiles/default/bin && \
    cp /usr/bin/busybox /out/nix/var/nix/profiles/default/bin/busybox && \
    ln -s busybox /out/nix/var/nix/profiles/default/bin/sh && \
    ln -s busybox /out/nix/var/nix/profiles/default/bin/bash

FROM scratch AS container
COPY --from=build /out/ /
