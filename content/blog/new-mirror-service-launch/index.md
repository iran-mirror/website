---
title: "Iranian Mirrors: A New Era of Container Registry Access Begins"
description: "Introducing our new mirror service for Docker, GHCR, and more. Join us in this early phase as we build the fastest mirror infrastructure for Iranian developers."
summary: "We're launching Iranian Mirrors — early access to Docker, GHCR, and container registries optimized for Iran."
date: 2026-08-19T00:00:00Z
draft: false
weight: 1
categories: ["announcement"]
tags: ["launch", "docker", "mirrors", "infrastructure"]
contributors: []
pinned: true
homepage: false
params:
  seo:
    title: "Iranian Mirrors Launch — Container Registry Access for Iran"
    description: "Introducing Iranian Mirrors: Docker, GHCR, and more. Fast, reliable container registry mirroring for Iranian developers."
---

## We're launching

Today marks the beginning of **Iranian Mirrors** — a community-driven initiative to bring fast, reliable container registry access to developers across Iran.

For too long, developers here have faced slow image pulls, timeouts, and blocked registries. We're changing that.

### What we're mirroring

We start with the essentials:

- **Docker Hub** — Official library images, millions of community projects
- **GitHub Container Registry (GHCR)** — Open-source projects, GitHub packages
- **Google Container Registry (GCR)** — Kubernetes, cloud-native tools
- **Amazon ECR Public** — AWS-maintained images

More registries are coming as we grow.

### Early phase, real infrastructure

We're launching in **early access**. That means:

- **Fast pulls** — Cached images served from our Iran-based infrastructure
- **Stable, monitored** — Uptime tracking and incident response from day one
- **Growing coverage** — We'll expand mirrors based on community demand
- **Free** — No cost to use, no API keys required

But it's early. You might find rough edges, and we're actively improving everything.

### How to get started

Using our mirrors is simple. Instead of pulling from Docker Hub:

```bash
# Before
docker pull nginx

# After
docker pull mirror.ir/library/nginx
```

See [how to use our mirrors](/docs/guides/getting-started/) for detailed setup across Docker, Kubernetes, and other tools.

### Why this matters

Iran's internet infrastructure has always been resilient, but container registries were an exception. Developers here spent hours waiting for pulls, worked around timeouts, and switched to older cached images. That's inefficient and frustrating.

Iranian Mirrors changes the equation. We're building local mirror infrastructure so that:

- Pulls happen in seconds, not minutes
- CI/CD pipelines are faster and more reliable
- Teams spend time building, not troubleshooting registry issues

### We're just beginning

This is day one. We have a roadmap of registries to add, regions to expand into, and features to build. We're doing this in the open, and we'd love your feedback.

Have a registry we should mirror? Hit timeouts or have questions? [Reach out to our community](https://github.com/iran-mirror/mirrory/issues) — we're reading every issue.

### Next steps

1. **Try it out** — Pull an image from our mirrors and see the difference
2. **Tell us what's missing** — Comment on issues, suggest registries, report problems
3. **Share with your team** — Help other developers in Iran discover faster access

Welcome to Iranian Mirrors. Let's build something great together.
