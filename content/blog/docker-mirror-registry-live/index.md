---
title: "Docker Mirror Registry Now Live at docker.repo.mirrory.ir"
description: "We've launched a dedicated Docker mirror registry at docker.repo.mirrory.ir with instant access to hundreds of thousands of images."
summary: "Docker Hub mirror now live — pull from docker.repo.mirrory.ir for fast, reliable access."
date: 2026-08-19T00:00:00Z
draft: false
weight: 2
categories: ["announcement"]
tags: ["docker", "registry", "launch", "infrastructure"]
contributors: []
pinned: true
homepage: false
params:
  seo:
    title: "Docker Mirror Live — docker.repo.mirrory.ir"
    description: "Docker Hub mirror registry live. Pull from docker.repo.mirrory.ir for fast, cached access to Docker images."
---

## Docker mirror is live

We're excited to announce that our **Docker Hub mirror registry** is now live and ready to use.

**Address:** `docker.repo.mirrory.ir`

Starting today, you can pull Docker images directly from our Iran-based infrastructure at full speed, with zero network timeouts and dramatically faster pulls.

### What's available

Our Docker mirror provides access to:

- **Official library images** — nginx, postgres, redis, ubuntu, python, node, and more
- **Verified publishers** — MongoDB, MySQL, Kubernetes, CNCF projects
- **Community images** — Millions of developer-maintained images from the Docker community
- **Automatic updates** — New images are cached within minutes of their upstream release

Think of it as Docker Hub, but fast. Every image from the official Docker Hub registry is available here without waiting for slow international links.

### Quick start

Pull an image from our mirror instead of Docker Hub:

**From Docker Hub (slow):**
```bash
docker pull nginx:latest
```

**From our mirror (fast):**
```bash
docker pull docker.repo.mirrory.ir/library/nginx:latest
```

For community images, just replace `docker.io` with `docker.repo.mirrory.ir`:

```bash
# Before
docker pull myrepo/myimage:tag

# After
docker pull docker.repo.mirrory.ir/myrepo/myimage:tag
```

### Integration options

**Option 1: Per-image (manual)**
```bash
docker pull docker.repo.mirrory.ir/library/nginx:latest
```

**Option 2: Configure Docker daemon (persistent)**
Edit `/etc/docker/daemon.json`:
```json
{
  "registry-mirrors": ["http://docker.repo.mirrory.ir"]
}
```
Then restart Docker and all pulls will use our mirror automatically.

**Option 3: Kubernetes (cluster-wide)**
Configure your kubelet's `--registry-mirrors` flag or use a pull-through cache in your cluster.

See [configuring Docker to use our mirrors](/docs/guides/docker-mirror-setup/) for detailed setup instructions across platforms.

### Why this matters

Docker Hub pulls from Iran have always been slow. International links, rate limiting, and network congestion meant:

- A 100MB image could take 10+ minutes to pull
- CI/CD pipelines failed with timeouts
- Teams cached old images locally instead of pulling fresh updates
- Development was slowed by infrastructure issues, not code

Our Docker mirror changes that. Now:

- Pulls are measured in seconds, not minutes
- CI/CD is reliable and fast
- You always get the latest images
- Development flows uninterrupted

### What's cached

We mirror the full Docker Hub library:

- Official library (ubuntu, alpine, nginx, postgres, python, node, golang, etc.)
- Verified publishers and official images
- Community images (both popular and niche)
- All architectures (amd64, arm64, arm/v7, etc.)

**New images are cached automatically** — if an image doesn't exist in our cache yet, we'll fetch it from Docker Hub and cache it for the next user.

### Performance

Early testing shows:

- Average pull time: **30-60 seconds** for typical images (vs. 5-10 minutes from Docker Hub)
- Uptime: **99.9%+** — monitored and maintained 24/7
- Bandwidth: Unlimited — no per-image or per-user rate limits

### Reliability

We monitor our registry constantly. If an image is corrupted or outdated, we flush it from cache and pull a fresh copy. You're always getting what Docker Hub published.

### What's next

We're already working on:

- Additional registries (GHCR, ECR, GCR coming soon)
- Regional mirrors for different Iranian ISPs
- Advanced analytics and usage stats
- Performance optimization based on usage patterns

### Give us feedback

Found a bug? Slow pull? Image missing? [Open an issue on GitHub](https://github.com/iran-mirror/mirrory/issues) and let us know. We're reading every report and using your feedback to improve.

### Get started now

1. **Pick your integration method** — per-image, daemon config, or Kubernetes
2. **Pull an image** — test with something small like `docker pull docker.repo.mirrory.ir/library/nginx:latest`
3. **Measure the difference** — notice how fast it is
4. **Configure your workflow** — update your CI/CD, Kubernetes, or personal setup

Welcome to fast Docker on your infrastructure. Let's make building on Docker in Iran instant again.
