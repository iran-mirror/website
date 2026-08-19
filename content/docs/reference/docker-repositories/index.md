---
title: "Docker Mirror Repository Reference"
slug: "docker-repositories"
description: "Complete reference of all Docker image repositories available on the Iranian Mirrors Docker registry at docker.repo.mirrory.ir"
date: 2026-08-19T00:00:00Z
draft: false
weight: 10
toc: true
params:
  math: false
  seo:
    title: "Docker Mirror Repositories — Complete Reference"
    description: "List of all Docker Hub repositories available on docker.repo.mirrory.ir mirror registry"
---

## Overview

This reference lists all Docker image repositories available through the Iranian Mirrors Docker registry at `docker.repo.mirrory.ir`. All images from Docker Hub are cached and available here with zero-latency access.

**Registry address:** `docker.repo.mirrory.ir`

## Official Library Images

The foundation of Docker containerization. All images are maintained by Docker and official open-source organizations.

### Base Operating Systems

- **ubuntu** — Canonical's Ubuntu Linux distribution
- **debian** — Debian GNU/Linux
- **alpine** — Lightweight Linux distribution
- **centos** — Community-driven enterprise Linux
- **rockylinux** — RHEL-compatible Linux distribution
- **fedora** — Bleeding-edge Linux distribution
- **busybox** — Lightweight Unix toolbox

### Development Runtimes

- **python** — Python interpreter (3.12, 3.11, 3.10, etc.)
- **node** — Node.js JavaScript runtime
- **golang** — Go programming language
- **rust** — Rust systems programming language
- **openjdk** — Open-source Java Development Kit
- **php** — PHP scripting language
- **ruby** — Ruby programming language
- **perl** — Perl programming language
- **dotnet** — .NET runtime
- **gradle** — Gradle build system
- **maven** — Maven build system

### Web Servers & Proxies

- **nginx** — High-performance web server and reverse proxy
- **apache2** — Apache HTTP Server
- **httpd** — Apache HTTP Server (alternative)
- **traefik** — Modern reverse proxy and load balancer
- **caddy** — The Swiss Army knife of web servers

### Databases

- **postgres** — PostgreSQL relational database
- **mysql** — MySQL relational database
- **mariadb** — MySQL-compatible database
- **mongodb** — NoSQL document database
- **redis** — In-memory data structure store
- **cassandra** — Distributed NoSQL database
- **elasticsearch** — Search and analytics engine
- **influxdb** — Time-series database
- **couchdb** — Document-oriented NoSQL database
- **memcached** — Distributed memory cache
- **neo4j** — Graph database

### Message Queues & Streaming

- **rabbitmq** — Open-source message broker
- **kafka** — Distributed event streaming platform
- **nats** — Cloud-native messaging system
- **redis** — Also used for pub/sub messaging
- **activemq** — Open-source message broker

### Container Orchestration & Cloud Native

- **kubernetes** — Kubernetes orchestration (various versions)
- **etcd** — Distributed key-value store for Kubernetes
- **consul** — Service mesh and service discovery
- **vault** — Secrets management

### Monitoring & Observability

- **prometheus** — Metrics and alerting
- **grafana** — Visualization and dashboarding
- **influxdb** — Time-series database for metrics
- **telegraf** — Metrics collection agent
- **jaeger** — Distributed tracing
- **logstash** — Data processing pipeline
- **kibana** — Elasticsearch visualization
- **fluentd** — Data collector for unified logging

### CI/CD Tools

- **jenkins** — Automation server
- **gitlab-runner** — GitLab CI/CD runner
- **gitea** — Self-hosted Git service
- **drone** — Continuous delivery platform
- **nexus** — Repository manager

### Testing & QA

- **selenium** — Web browser automation
- **chromium** — Headless chromium for testing
- **cypress** — End-to-end testing framework

### Storage & File Systems

- **minio** — Object storage server (S3-compatible)
- **ceph** — Distributed storage system
- **glusterfs** — Scalable storage

### Security

- **vault** — Secrets management
- **openldap** — LDAP directory service
- **keycloak** — Identity and access management

## Verified Publishers

Curated images from organizations with Docker verification.

- **mongo** — Official MongoDB
- **mysql** — Official MySQL
- **postgres** — Official PostgreSQL
- **redis** — Official Redis
- **nginx** — Official Nginx
- **rabbitmq** — Official RabbitMQ
- **elasticsearch** — Official Elasticsearch
- **kafka** — Confluent Kafka
- **consul** — HashiCorp Consul
- **vault** — HashiCorp Vault
- **prom/prometheus** — Prometheus project
- **grafana/grafana** — Grafana Labs Grafana
- **circleci/circleci-docs** — CircleCI documentation
- **microsoft/dotnet** — Microsoft .NET images

## Community Images

Millions of community-maintained images. Common categories:

### Framework & Application Servers

- **django** — Python web framework
- **flask** — Lightweight Python web framework
- **express** — Node.js web framework
- **spring** — Java application framework
- **rails** — Ruby web framework
- **laravel** — PHP web framework
- **asp.net** — .NET web framework
- **tomcat** — Java application server
- **jetty** — Java web server
- **jboss** — Enterprise application server

### Machine Learning & Data Science

- **tensorflow** — Deep learning framework
- **pytorch** — Deep learning framework
- **jupyter** — Interactive computing
- **anaconda** — Python data science platform
- **r-base** — R statistical computing

### Productivity & Utilities

- **wordpress** — Website platform
- **nextcloud** — File sync and share
- **gitlab** — Git repository platform
- **gitea** — Lightweight Git service
- **mattermost** — Team communication
- **rocket.chat** — Open-source chat
- **zulip** — Open-source team chat
- **discourse** — Community discussion platform

### Media & Content

- **jellyfin** — Media server
- **plex** — Media server
- **pihole** — DNS-level ad blocking
- **sonarr** — TV show automation
- **radarr** — Movie automation
- **lidarr** — Music automation

## Pulling Images

### Basic Pull

```bash
docker pull docker.repo.mirrory.ir/library/nginx:latest
```

### Community Image Pull

```bash
docker pull docker.repo.mirrory.ir/tensorflow/tensorflow:latest
```

### Specific Version

```bash
docker pull docker.repo.mirrory.ir/library/postgres:15-alpine
```

## Image Naming

All images follow Docker Hub naming conventions:

- **Official images:** `docker.repo.mirrory.ir/library/IMAGE:tag`
- **Verified publisher:** `docker.repo.mirrory.ir/PUBLISHER/IMAGE:tag`
- **Community images:** `docker.repo.mirrory.ir/USERNAME/IMAGE:tag`

## Supported Architectures

All images are available in multiple architectures:

- `amd64` — Intel/AMD 64-bit (most common)
- `arm64` — ARM 64-bit (Apple Silicon, modern Android, newer RPi)
- `arm/v7` — ARM 32-bit (older Raspberry Pi, some IoT)
- `ppc64le` — PowerPC 64-bit little-endian
- `s390x` — IBM System z architecture

Architecture selection is automatic — Docker will pull the correct variant for your system.

## Caching & Updates

**New images:** If an image isn't in our cache yet, we automatically fetch it from Docker Hub and cache it for future pulls.

**Stale images:** We keep all cached images up-to-date with Docker Hub. Updates are synced hourly.

**Image verification:** All images are verified against Docker Hub to ensure integrity.

## Mirrors for Other Registries

Beyond Docker Hub, we also mirror:

- **GitHub Container Registry (GHCR)** — `ghcr.repo.mirrory.ir`
- **Google Container Registry (GCR)** — `gcr.repo.mirrory.ir`
- **Amazon ECR Public** — `ecr.repo.mirrory.ir`

See the [complete registry reference](/docs/reference/mirror-registries/) for all available mirrors.

## Performance

Typical pull times:

- **First pull (cache miss):** 30-120 seconds (depending on image size)
- **Subsequent pulls (cache hit):** 5-30 seconds
- **Bandwidth:** No rate limiting

For very large images (1GB+), pulls may take longer but are still faster than international links.

## Limitations & Considerations

- **Images must be public** — Private Docker Hub images are not mirrored
- **Layer consistency** — All layers are cached from the source; removed layers become unavailable
- **Tag mutability** — If an image author changes a tag's content, our cache eventually reflects it (within 24 hours)

## Reporting Issues

Found a missing image? Image corruption? Performance issue?

[Open an issue on GitHub](https://github.com/iran-mirror/website/issues) with:
- Image name and tag
- Error message or behavior
- Your system details (OS, Docker version, architecture)

We'll investigate and resolve within 24 hours.

## What's Coming

- **Regional mirrors** — Separate mirrors optimized for different ISPs
- **Usage statistics** — See which images are most popular
- **Mirror authentication** — Optional token-based access control
- **Webhook support** — Notifications when images update

---

**Last updated:** 2026-08-19

All images on this page are available at `docker.repo.mirrory.ir`. Start using it today.
