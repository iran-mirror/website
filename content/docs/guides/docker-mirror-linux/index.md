---
title: "How to Use Docker Registry Mirrors in Linux"
slug: "docker-mirror-linux"
description: "Learn how to configure Docker to use registry mirrors for faster image pulls and reduced bandwidth in Linux environments"
date: 2026-08-19
draft: false
weight: 10
toc: true
categories: ["Docker", "Container Registry"]
tags: ["Docker", "mirrors", "Linux", "configuration"]
contributors: []
params:
  math: false
  seo:
    title: "Configure Docker Registry Mirrors in Linux"
    description: "Step-by-step guide to set up Docker registry mirrors on Linux for faster image pulls and resilience"
    canonical: ""
    robots: ""
---

## Overview

Docker registry mirrors accelerate image pulls by caching layers closer to your infrastructure, reduce bandwidth costs, and improve resilience to upstream registry outages. This guide walks you through configuring Docker to use mirror registries on Linux systems.

By the end, you'll be able to:
- Understand how Docker discovers and uses mirror registries
- Configure Docker daemon to use one or more mirrors
- Verify mirror connectivity and test image pulls
- Troubleshoot common mirror-related issues

## Prerequisites

- Docker installed and running on a Linux system (Ubuntu, Debian, CentOS, Fedora, etc.)
- Root or sudo access to modify Docker configuration
- Basic familiarity with JSON configuration files
- Network access to both Docker Hub and your mirror registries

## Step 1: Understand Docker Mirror Configuration

Docker mirrors are configured in the daemon configuration file at `/etc/docker/daemon.json`. When you specify a mirror for a registry, Docker tries to pull images from the mirror first before falling back to the primary registry if needed.

**Key concepts:**
- **Primary registry**: The default source (e.g., Docker Hub for images like `nginx:latest`)
- **Mirror registry**: An alternative source that caches layers from the primary registry
- **Fallback behavior**: Docker automatically retries the primary registry if the mirror fails

## Step 2: Create or Edit the Docker Daemon Configuration

If `/etc/docker/daemon.json` doesn't exist, create it:

```bash
sudo touch /etc/docker/daemon.json
```

Open the file with your preferred editor:

```bash
sudo nano /etc/docker/daemon.json
```

or

```bash
sudo vim /etc/docker/daemon.json
```

## Step 3: Configure a Single Mirror

The simplest configuration uses a single mirror for Docker Hub. Add or update the `"registry-mirrors"` key:

```json
{
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

If the file already contains other settings, merge the `registry-mirrors` key:

```json
{
  "debug": false,
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

## Step 4: Configure Multiple Mirrors (Fallback Priority)

To specify multiple mirrors, Docker tries them in order. The first available mirror is used; if it fails, Docker retries in sequence:

```json
{
  "registry-mirrors": [
    "https://docker.repo.mirrory.ir",
    "https://docker-mirror.backup.local"
  ]
}
```

Docker attempts mirrors in the order listed. Use this for redundancy and load distribution.

## Step 5: Configure Mirrors for Specific Registries

For registries other than Docker Hub (e.g., GitHub Container Registry, Google Container Registry), use `"registry-mirrors"` as a key under each registry in the `"registries"` object:

```json
{
  "registry-mirrors": ["https://docker.repo.mirrory.ir"],
  "registries": {
    "ghcr.io": {
      "mirrors": ["https://ghcr.repo.mirrory.ir"]
    },
    "gcr.io": {
      "mirrors": ["https://gcr.repo.mirrory.ir"]
    }
  }
}
```

This configuration:
- Uses `docker.repo.mirrory.ir` for Docker Hub images
- Uses `ghcr.repo.mirrory.ir` for GitHub Container Registry (`ghcr.io`)
- Uses `gcr.repo.mirrory.ir` for Google Container Registry (`gcr.io`)

## Step 6: Reload Docker Daemon and Verify Configuration

Save the configuration file and reload the Docker daemon:

```bash
sudo systemctl reload docker
```

If Docker isn't using systemd, use:

```bash
sudo service docker restart
```

Verify the configuration was loaded:

```bash
docker info | grep -A 5 "Registry Mirrors"
```

Output should show your mirror registry:

```
Registry Mirrors:
 https://docker.repo.mirrory.ir/
```

## Step 7: Test Mirror Connectivity

Pull a test image to verify the mirror is working:

```bash
docker pull nginx:latest
```

Monitor the pull to confirm the mirror is being used. Check Docker logs for mirror-related events:

```bash
sudo journalctl -u docker --since "5 min ago" | grep -i mirror
```

Or on systems using Docker's native logging:

```bash
docker events --filter type=image &
docker pull nginx:latest
```

## Step 8: Verify Cache and Performance

To confirm the mirror is caching layers, pull the same image again. It should complete faster:

```bash
docker pull nginx:latest
# Second pull should complete in seconds, indicating cache hits
```

Check pull history with detailed output:

```bash
docker pull --verbose nginx:latest 2>&1 | grep -E "Pulling|Downloaded|Pull complete"
```

## Step 9: Handle Authentication (If Required)

If your mirror registry requires authentication, configure credentials in `~/.docker/config.json`:

```bash
docker login docker.repo.mirrory.ir
```

This stores encrypted credentials that Docker uses automatically when pulling from the mirror.

Verify credentials are saved:

```bash
cat ~/.docker/config.json | jq '.auths'
```

## Step 10: Troubleshooting Common Issues

### Mirror is unreachable

Check network connectivity to the mirror:

```bash
curl -I https://docker.repo.mirrory.ir/v2/
```

Expected response: `200 OK` or `401 Unauthorized` (if authentication is required).

### Docker falls back to primary registry instead of using mirror

Check daemon logs:

```bash
sudo journalctl -u docker -n 50
```

Look for errors like `connection refused` or `certificate verify failed`.

Verify the mirror URL is correct in `daemon.json` and the daemon was reloaded.

### Pull succeeds but subsequent pulls are slow

The mirror may not be caching layers properly. Verify:

1. Mirror storage has sufficient disk space
2. Mirror service is running (`docker ps` if mirror is containerized)
3. Network latency between your Docker host and mirror is low (`ping mirror.example.com`)

### Certificate errors ("x509: certificate signed by unknown authority")

If using a self-signed certificate, disable TLS verification (not recommended for production):

```json
{
  "insecure-registries": ["docker.repo.mirrory.ir"],
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

Better solution: add the mirror's CA certificate to your system's trust store:

```bash
sudo cp docker-repo-mirrory-ir-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
sudo systemctl reload docker
```

## Best Practices

1. **Use HTTPS**: Always use `https://` for mirror URLs in production to prevent man-in-the-middle attacks.
2. **Monitor mirror availability**: Include multiple mirrors for redundancy; Docker will failover automatically.
3. **Test regularly**: Periodically pull images to ensure the mirror is working.
4. **Keep mirrors updated**: Ensure your mirror registry is running a recent, secure version.
5. **Document your setup**: Annotate your `daemon.json` with comments explaining why mirrors are configured.
6. **Measure impact**: Compare pull times and bandwidth usage before and after enabling mirrors.

## Next Steps

- **Learn about mirror protocols**: Understand Docker Registry V2 API and how mirrors implement it
- **Set up your own mirror**: Deploy a private mirror registry for air-gapped or offline environments
- **Monitor mirror health**: Set up alerting for mirror unavailability or poor performance
- **Optimize layer caching**: Configure mirror storage and garbage collection policies

## Summary

Docker registry mirrors are a powerful way to improve image pull performance and reduce bandwidth. With the configuration steps above, you can:

- ✓ Configure a single or multiple mirrors
- ✓ Set mirrors for specific registries
- ✓ Verify mirror operation and performance
- ✓ Troubleshoot common issues
- ✓ Apply best practices for security and reliability

For more details, refer to the [Docker documentation on registry mirrors](https://docs.docker.com/docker-hub/mirror/) and your mirror provider's configuration guide.
