# headscale-docker

Docker image build for the [RWTS headscale fork](https://github.com/realworldtech/headscale/tree/feature/suggest-exit-nodes) with `suggestExitNodes` support.

## Usage

```bash
docker pull ghcr.io/realworldtech/headscale-docker:latest
```

In your `compose.yaml`:

```yaml
services:
  headscale:
    image: ghcr.io/realworldtech/headscale-docker:latest
    # ...
```

## What's different

This image adds a `suggestExitNodes` ACL policy field to headscale, allowing
administrators to designate specific exit nodes for Tailscale client
auto-selection. See the [fork branch](https://github.com/realworldtech/headscale/tree/feature/suggest-exit-nodes)
for details.

## Building locally

```bash
docker build -t headscale-custom:latest .
```

To build from a different branch or repo:

```bash
docker build \
  --build-arg HEADSCALE_REPO=https://github.com/realworldtech/headscale.git \
  --build-arg HEADSCALE_REF=feature/suggest-exit-nodes \
  -t headscale-custom:latest .
```
