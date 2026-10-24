FROM ghcr.io/siderolabs/stagex/core-busybox:2026.09.0@sha256:59b3d3e754c09c408e598fe32c52bfbd99c3a0a7aa52c356768e1d3d9a46562f AS busybox

FROM scratch AS build
COPY --from=busybox / /
RUN mkdir -p /out/nix/var/nix/profiles/default/bin && \
    cp /usr/bin/busybox /out/nix/var/nix/profiles/default/bin/busybox && \
    ln -s busybox /out/nix/var/nix/profiles/default/bin/sh && \
    ln -s busybox /out/nix/var/nix/profiles/default/bin/bash

FROM scratch AS container
COPY --from=build /out/ /
