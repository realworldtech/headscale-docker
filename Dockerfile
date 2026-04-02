FROM golang:1.26-bookworm AS builder

ARG HEADSCALE_REPO=https://github.com/realworldtech/headscale.git
ARG HEADSCALE_REF=feature/suggest-exit-nodes

WORKDIR /build
RUN git clone --depth 1 --branch ${HEADSCALE_REF} ${HEADSCALE_REPO} . \
    && CGO_ENABLED=0 go build -o headscale ./cmd/headscale/

FROM gcr.io/distroless/base-debian12
COPY --from=builder /build/headscale /ko-app/headscale
ENV PATH="/ko-app:${PATH}"
ENTRYPOINT ["/ko-app/headscale"]
