FROM golang:1.26-bookworm AS builder

ARG HEADSCALE_REPO=https://github.com/realworldtech/headscale.git
ARG HEADSCALE_REF=feature/suggest-exit-nodes

WORKDIR /build
RUN git clone --branch ${HEADSCALE_REF} ${HEADSCALE_REPO} . \
    && git fetch --tags https://github.com/juanfont/headscale.git \
    && CGO_ENABLED=0 go build -o headscale ./cmd/headscale/

FROM gcr.io/distroless/base-debian12
COPY --from=builder /build/headscale /ko-app/headscale
ENV PATH="/ko-app:${PATH}"
ENTRYPOINT ["/ko-app/headscale"]
