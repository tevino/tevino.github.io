# AGENTS.md

Rules and principles for agents working on this Jekyll blog.

## Project overview

Personal bilingual (en/zh) blog for tevinzhang.com. Jekyll site with the
**Minima** theme loaded as a *remote theme* (pinned commit in `src/_config.yml`).
All site source lives in `src/`; that directory is the Jekyll project root.

## Repo layout

```
src/
  _config.yml            # site config, remote_theme pin, minima options
  _sass/minima/
    custom-styles.scss   # THE place for CSS customization (see Theming)
  _includes/
    custom-head.html     # THE place for <head> customization (see Theming)
  _posts/en|zh/          # blog posts: YYYY-MM-DD-slug.md
  _includes, _layouts/   # site-specific includes/layouts (may edit)
  Makefile               # Docker-based dev commands (run from src/)
```

## Development workflow

- Dev server runs in Docker (image `jekyll-blog`), port 4000. All commands run from `src/`:
  - `make dev` — live-reload server (**requires a TTY**)
  - Non-TTY fallback: `docker run --rm -d --name jekyll-dev -p 4000:4000 -v "$(pwd)":/srv/jekyll --user $(id -u):$(id -g) jekyll-blog bundle exec jekyll serve --host 0.0.0.0 --port 4000 --watch`
  - `make build` — production build; `make stop` — stop the container
- The root URL redirects to `/en/`. Verify pages with `curl http://127.0.0.1:4000/en/...`.
- **Verify CSS changes** by inspecting the compiled output:
  `curl -s http://127.0.0.1:4000/assets/css/style.css` — it is minified, so grep for specific property names (e.g. `--minima-background-color`).
- Never commit Docker artifacts, or `src/_site/`.

## Theming rules (important)

1. **Never modify theme files.** The theme is a remote dependency fetched by
   `jekyll-remote-theme`; edits to it don't persist. Make external customization 
   like `src/_sass/minima/custom-styles.scss` and `src/_includes/custom-head.html`
   , so theme upgrades don't clobber our changes.
2. **Override Minima's own CSS variables.** They are `--minima-*` prefixed
   (`--minima-background-color`, `--minima-link-base-color`, ...). Defining
   generic names like `--body-bg-color` has no effect. `custom-styles.scss`
   compiles after the theme, so same-name overrides win the cascade.
3. **Dark mode** is handled with a `@media (prefers-color-scheme: dark)` block
   that redefines the accent token (`--brand-blue` becomes a lightened blue);
   background and text ink get their own dark tokens. Anything built from
   `var(--brand-blue)` adapts automatically.
4. **Color scheme** — cream `#FFFBEA` (background), blue `#0F64B5` (accent),
   dark bg `#1a1f24`. Use the brand tokens:
   - `--brand-cream`, `--brand-blue`, `--brand-ink` (defined in `:root`)
   - Derive tints/shades with `color-mix(in srgb, ...)` — no extra raw hexes.
   `color-mix()` is acceptable (modern-browser support is fine for this project).
5. **Keep `custom-head.html` in sync** with the SCSS tokens: `theme-color`
   (light/dark), `msapplication-TileColor`, and `mask-icon` colors are static
   copies of `--brand-cream` / dark bg / `--brand-blue`.

## Content conventions

- Bilingual: pages and posts come in `*.en.md` / `*.zh.md` pairs. When
  editing content, apply the change to **both languages** unless told otherwise.
- Language code is the **first path segment** (`/en/...`, `/zh/...`); all URLs
  end with a trailing slash.
- Markdown is CommonMark (extensions: strikethrough, autolink, table;
  footnotes enabled). Links in prose use reference-style `[label][key]`.
- `permalink: pretty` globally; post permalinks are set via config defaults.
- Keep diffs focused on the task; flag unrelated pre-existing changes (e.g.
  `Gemfile.lock` churn from `bundle`) instead of silently fixing or reverting them.

## General principles

- Prefer token-driven, self-documenting CSS (named tokens + comments) over
  scattered magic values.
- Verify before claiming: serve in Docker, fetch the page, inspect compiled HTML and CSS.
- Small, reversible edits; keep existing code style (4-space indent in SCSS).
