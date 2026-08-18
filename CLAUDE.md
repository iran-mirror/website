# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Hugo static site ("Iranian Mirrors" / mirrory) built on the **Doks** theme, consumed as npm packages rather than as a Hugo module or git submodule. The site documents Iranian container-registry mirrors (docker, ghcr, gcr, …). Deployment targets are both Netlify and a self-hosted Kubernetes/ArgoCD pipeline via a Docker image.

## Commands

```bash
npm install                # required before any hugo command — see "node_modules is load-bearing"
npm run dev                # hugo server --disableFastRender --noHTTPCache  → http://localhost:1313
npm run build              # hugo --minify --gc → public/
npm run create <path>      # hugo new — scaffolds content from archetypes
npm run format             # prettier -w over the repo
npm run preview            # vite preview --outDir public (serve an existing build)
```

There is no test suite and no linter beyond Prettier.

Docker (mirrors the CI build):

```bash
docker build --target dev -t mirrory-dev .   && docker run -p 1313:1313 mirrory-dev
docker build -t mirrory .                    && docker run -p 8080:8080 mirrory   # nginx runtime
```

### Environment / version pinning

`netlify.toml` `[build.environment]` is the source of truth for tool versions; `Dockerfile` ARGs deliberately mirror it (Node 24.13.1, Hugo 0.156.0). Change both together. **Hugo extended is required** — layouts compile SCSS via `toCSS`. `package.json` declares `engines.node >= 24.13.0`.

## Architecture

### node_modules is load-bearing

`config/_default/module.toml` mounts theme layouts, assets, data, i18n, archetypes, and static files **directly out of `node_modules/`** (`@thulite/doks-core`, `@thulite/core`, `@thulite/seo`, `@thulite/images`, `@thulite/inline-svg`, `@tabler/icons`). `npm ci`/`npm install` is not optional before building — without it Hugo has no theme at all. This is also why `Dockerfile` copies `node_modules` into both the `build` and `dev` stages.

Mount order matters: later mounts of the same target layer over earlier ones. Project `layouts/`, `assets/`, `data/`, `i18n/`, `static/` are mounted so they win over the package versions.

### Overriding theme files

To customize a theme layout, copy it from `node_modules/@thulite/doks-core/layouts/...` into the matching path under `layouts/` and edit there. One special case is already wired: the doks-core layouts mount excludes `home.html` (`files = ['! home.html']`), so [layouts/home.html](layouts/home.html) is the project's own homepage and defines the `main`, `sidebar-prefooter`, and `sidebar-footer` blocks. Everything else in `layouts/` is currently just customization stubs:

- [layouts/_partials/head/custom-head.html](layouts/_partials/head/custom-head.html), [script-header.html](layouts/_partials/head/script-header.html)
- [layouts/_partials/footer/script-footer-custom.html](layouts/_partials/footer/script-footer-custom.html) — has commented examples of conditionally loading JS via the `footer/esbuild` partial
- [assets/scss/common/_custom.scss](assets/scss/common/_custom.scss), [_variables-custom.scss](assets/scss/common/_variables-custom.scss), [assets/js/custom.js](assets/js/custom.js)

### Configuration

Split across `config/`:

- `config/_default/hugo.toml` — output formats (including custom `searchIndex`, `markdown`, `llms`, and section `sitemap`), taxonomies (`contributors`/`categories`/`tags`), permalinks, minify, pagination
- `config/_default/params.toml` — the big one. All Doks feature toggles live under `[doks]` (color mode, FlexSearch, section nav, versioning, multilingual, UX flags), plus `[thulite_images]`, `[inline_svg]`, `[seo]`
- `config/_default/languages.toml` — en/de/nl/fa defined, but `disableLanguages = ["de", "nl", "fa"]` in `hugo.toml` means only English builds. Note these entries set `contentDir = "content/<lang>"` while actual content lives flat in `content/` (mounted `content` → `content`); if you re-enable a language, reconcile that first.
- `config/next/hugo.toml`, `config/production/hugo.toml` — per-environment `baseurl` overrides, selected by `HUGO_ENVIRONMENT`

### CSS pipeline / PurgeCSS

`[build.buildStats] enable = true` makes Hugo write `hugo_stats.json` (every tag/class/id it emitted), which `module.toml` mounts as `assets/watching/hugo_stats.json`. `config/postcss.config.js` feeds that file to PurgeCSS — **but only when `HUGO_ENVIRONMENT=production`**. Consequence: a class that only appears in JS-generated markup gets stripped from production CSS while working fine in dev. Add such classes to the `safelist` (or `dynamicAttributes`) in `config/postcss.config.js`. `hugo_stats.json` is committed on purpose.

### Content conventions

Content lives in `content/`, with `mainSections = ["docs"]` and section nav enabled for `docs`. Front matter across all pages carries a `params.seo` block (`title`/`description`/`canonical`/`robots`) — keep it when adding pages. Section `_index.md` files also carry `params.section` (`title`, `iconName` from Tabler icons, `startUrl`). `weight` drives ordering. Permalinks: `blog` → `/blog/:slug/`, `docs` → `/docs/:sections[1:]/:slug/`.

### Deployment

Two paths from the same tree:

1. **Netlify** — `netlify.toml` runs `npm install && hugo build --gc --minify --baseURL "$URL"`, plus a `/*` → `/404/` redirect and a security-header block.
2. **Container** — multi-stage [Dockerfile](Dockerfile) (`base` → `deps` → `build` → `runtime` nginx on :8080; separate `dev` target). `docker/nginx.conf` and `docker/security-headers.conf` deliberately replicate the Netlify headers and 404 behaviour so the container matches the deployed site. The nginx config assumes it runs behind a TLS-terminating proxy (`absolute_redirect off`, `real_ip_header X-Forwarded-For`) — don't remove those without understanding the redirect-downgrade comment there.

CI ([.github/workflows/image.yaml](.github/workflows/image.yaml)) calls reusable workflows from `iran-mirror/gh-actions` on every push: build/push the image, then trigger ArgoCD. If you change the security headers in `netlify.toml`, update `docker/security-headers.conf` to match.

## Formatting

Prettier config is unusual and intentional: `tabWidth: 4`, `endOfLine: crlf`, `singleQuote: true`, `printWidth: 100000` (effectively no wrapping), `bracketSameLine: true`. Markdown/JSON/YAML override to `tabWidth: 2` + double quotes. `.prettierignore` excludes all `*.html` and `*.toml`, so Hugo templates and config files are formatted by hand — match surrounding style there (`.vscode/settings.json` sets 2-space indent for the editor).
