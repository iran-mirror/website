# syntax=docker/dockerfile:1

# Versions mirror netlify.toml [build.environment] so local and CI builds match.
ARG NODE_VERSION=24.13.1
ARG HUGO_VERSION=0.156.0

# ---------------------------------------------------------------------------
# base — Node + Hugo extended (extended is required: layouts use libsass toCSS)
# ---------------------------------------------------------------------------
FROM node:${NODE_VERSION}-bookworm-slim AS base
ARG HUGO_VERSION
ARG TARGETARCH

ENV TZ=Europe/Amsterdam \
    NODE_ENV=development

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git \
 && rm -rf /var/lib/apt/lists/* \
 && case "${TARGETARCH}" in \
      amd64) HUGO_ARCH=amd64 ;; \
      arm64) HUGO_ARCH=arm64 ;; \
      *) echo "unsupported arch: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
 && curl -fsSL -o /tmp/hugo.tar.gz \
      "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz" \
 && tar -xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo \
 && rm /tmp/hugo.tar.gz \
 && hugo version

WORKDIR /src

# ---------------------------------------------------------------------------
# deps — npm install only, cached independently of content changes.
# node_modules is not optional: config/_default/module.toml mounts theme
# layouts/assets straight out of it, and postCSS runs from it at build time.
# ---------------------------------------------------------------------------
FROM base AS deps
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

# ---------------------------------------------------------------------------
# build — static site into /src/public
# ---------------------------------------------------------------------------
FROM base AS build
ARG BASE_URL=/
# Consumed by config/postcss.config.js to enable PurgeCSS.
ENV HUGO_ENVIRONMENT=production \
    HUGO_ENV=production

COPY --from=deps /src/node_modules ./node_modules
COPY . .

# Stale local artifacts must not leak into the image.
RUN rm -rf public resources .hugo_build.lock \
 && hugo build --gc --minify --baseURL "${BASE_URL}"

# ---------------------------------------------------------------------------
# dev — live-reload server: docker run -p 1313:1313 --target dev
# ---------------------------------------------------------------------------
FROM base AS dev
ENV HUGO_ENVIRONMENT=development \
    HUGO_ENV=development
COPY --from=deps /src/node_modules ./node_modules
COPY . .
EXPOSE 1313
CMD ["hugo", "server", "--disableFastRender", "--noHTTPCache", "--bind", "0.0.0.0", "--port", "1313"]

# ---------------------------------------------------------------------------
# runtime — nginx serving the built site (default target)
# ---------------------------------------------------------------------------
FROM nginx:1.29-alpine AS runtime

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/security-headers.conf /etc/nginx/snippets/security-headers.conf
COPY --from=build /src/public /usr/share/nginx/html

EXPOSE 8080


CMD ["nginx", "-g", "daemon off;"]
