# Write Mirror Content

Publish professional blog posts and documentation about mirror infrastructure with fact-checking and bilingual (English → Persian) support.

## What it does

1. **Guides content planning**: Suggests topics tied to your mirror services (Docker registries, container registries, OS repos)
2. **Writes in English first**: Produces clear, technical content with inline fact verification
3. **Translates to Persian**: Creates `.fa.md` versions after English approval
4. **Validates structure**: Ensures posts follow the site's frontmatter conventions and Diátaxis framework
5. **Publishes to correct sections**: Blog posts, how-to guides, or reference docs

## How to use it

```
/write-mirror-content [type] [topic]
```

**Types:**
- `blog` — Announcements, updates, highlights (e.g., "blog New Docker mirror region available")
- `guide` — Step-by-step tutorials (e.g., "guide How to configure your images to use our mirrors")
- `reference` — Concept docs, API reference, capabilities (e.g., "reference Supported mirror registries")

**Examples:**
```
/write-mirror-content blog New Docker mirror region available
/write-mirror-content guide Pull images faster using our Docker mirror
/write-mirror-content reference Supported OS repositories and mirrors
```

## Output

The skill creates:
1. **English content** — `content/{blog|docs/guides|docs/reference}/{slug}/index.md`
2. **Persian translation** — `content/{blog|docs/guides|docs/reference}/{slug}/index.fa.md`
3. **SEO frontmatter** — title, description, slug, date, weight (auto-calculated)
4. **Table of contents** — auto-enabled for guides/references

## Fact-checking rules

Before translating:
- **Mirror infrastructure claims** (e.g., "we mirror X in region Y") — verify against your infra docs or `/docs/resources`
- **Version numbers, release dates** — check against official upstream sources
- **Performance/reliability claims** — cite your monitoring or status page
- **Registry/repo support** — validate against your current mirror capabilities
- **URLs and external links** — ensure they're accurate and live

## Frontmatter template

### Blog posts
```yaml
title: "Title"
description: "One sentence summary of what changed and why it matters"
summary: "Optional: shorter tagline"
date: [current timestamp]
draft: false
weight: [auto-order]
categories: []
tags: []
contributors: []
pinned: false  # set true for featured posts
homepage: false
params:
  seo:
    title: "" # override if needed
    description: ""
```

### Guides (how-to)
```yaml
title: "How to [action]"
slug: "your-slug"
description: "Learn how to [task] step by step"
draft: false
weight: [auto-order]
toc: true  # required for guides
params:
  math: false
  seo: {...}
```

### Reference
```yaml
title: "[Concept] Reference"
slug: "concept-reference"
description: "Complete reference for [concept]: options, behavior, limitations"
draft: false
weight: [auto-order]
toc: true  # required for reference
params:
  seo: {...}
```

## Content framework (Diátaxis)

- **Blog** → Overview + Context + Guidance + Next steps
- **Guide** → Step-by-step workflow; user goal is "I need to do X"
- **Reference** → Comprehensive, terse docs; user goal is "I need to know Y"

## Language notes

English (en):
- Clear, direct, technical
- Audience: developers, ops engineers, sysadmins globally
- Assume familiarity with Docker, Kubernetes, package managers

Persian (fa):
- Same structure, translated semantically (not literally)
- Use standard container/infra terminology in English when no Persian term exists
- Date format: Gregorian (numbers only, no Persian numerals)
- Preserve code blocks, links, and technical terms in English

## Commands available within the skill

```bash
npm run create blog/your-post-name         # scaffold a new blog post
npm run create docs/guides/your-guide      # scaffold a new guide
npm run create docs/reference/your-ref     # scaffold a new reference page
npm run build                              # build and test the site locally
npm run preview                            # preview your changes before deploy
```

## Publishing workflow

1. Write English version (in-skill)
2. Review facts against resources (in-skill)
3. Translate to Persian (in-skill)
4. Preview site: `npm run dev` → http://localhost:1313
5. Commit to git and push (outside skill)
6. CI deploys automatically to Netlify + ArgoCD

## SEO and metadata

Every post carries `params.seo`:
- `title` — custom title if default doesn't fit (60 chars)
- `description` — meta description for search (160 chars)
- `canonical` — if cross-posted elsewhere
- `robots` — noindex/follow rules if needed

## File location reference

```
content/
├── blog/
│   └── your-post-slug/
│       ├── index.md          (English)
│       └── index.fa.md       (Persian)
├── docs/
│   ├── guides/
│   │   └── your-guide-slug/
│   │       ├── index.md
│   │       └── index.fa.md
│   └── reference/
│       └── your-ref-slug/
│           ├── index.md
│           └── index.fa.md
```

Languages: only `en` and `fa` are enabled (German and Dutch are disabled in `hugo.toml`).
