# Iranian Mirrors (mirrory)

A [Hugo](https://gohugo.io) static site documenting Iranian container-registry mirrors (Docker Hub, GHCR, GCR, and others). Built on the [Doks](https://getdoks.org) theme, consumed as npm packages rather than as a Hugo module or git submodule.

## Requirements

- Node.js `>= 24.13.0`
- [Hugo extended](https://gohugo.io/installation/) `0.156.0` (layouts compile SCSS via `toCSS`, which requires the extended edition)

Exact tool versions are pinned in `netlify.toml` under `[build.environment]`; `Dockerfile` ARGs mirror those values.

## Getting started

```bash
npm install     # required before any hugo command — theme layouts/assets/data live in node_modules
npm run dev     # hugo server --disableFastRender --noHTTPCache → http://localhost:1313
```

`npm install` is not optional: `config/_default/module.toml` mounts theme layouts, assets, data, i18n, archetypes, and static files directly out of `node_modules/@thulite/*`. Without it, Hugo has no theme.

## Commands

```bash
npm install                # install dependencies (theme comes from node_modules)
npm run dev                # start the dev server at http://localhost:1313
npm run build               # hugo --minify --gc → public/
npm run create <path>      # hugo new — scaffold content from archetypes
npm run format              # prettier -w over the repo
npm run preview             # vite preview --outDir public (serve an existing build)
```

There is no test suite and no linter beyond Prettier.

## Running with Docker

```bash
# Dev server with live reload
docker build --target dev -t mirrory-dev .
docker run -p 1313:1313 mirrory-dev

# Production build served by nginx
docker build -t mirrory .
docker run -p 8080:8080 mirrory
```

## Project structure

- `content/` — site content (`docs`, `blog`, `contributors`, `categories`, `tags`, ...). `mainSections = ["docs"]`.
- `layouts/` — project-specific layout overrides. Only files placed here take precedence over the theme's versions in `node_modules/@thulite/doks-core/layouts`. [layouts/home.html](layouts/home.html) is the project's own homepage.
- `assets/scss/common/_custom.scss`, `_variables-custom.scss` and `assets/js/custom.js` — project styling/script hooks.
- `config/` — split by environment (`_default`, `next`, `production`); see `config/_default/params.toml` for feature toggles under `[doks]`.
- `docker/` — nginx config and security headers used by the production container image.

See [CLAUDE.md](CLAUDE.md) for a deeper architectural walkthrough (module mounting, PurgeCSS/hugo_stats.json pipeline, content conventions, deployment paths).

## Deployment

Two paths build from the same tree:

1. **Netlify** — `netlify.toml` runs `npm install && hugo build --gc --minify --baseURL "$URL"`.
2. **Container** — the multi-stage [Dockerfile](Dockerfile) builds a static `public/` and serves it with nginx on port 8080, behind a TLS-terminating proxy. CI ([.github/workflows/image.yaml](.github/workflows/image.yaml)) builds/pushes the image and triggers ArgoCD on every push.

## License

MIT — see [LICENSE](LICENSE).
