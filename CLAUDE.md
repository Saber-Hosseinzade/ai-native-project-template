# CLAUDE.md

Context for AI coding assistants working in this repo. Personal and machine-specific notes go in
`CLAUDE.local.md` (git-ignored), which is read alongside this file.

## What this is

<!-- Replace per project: one or two sentences on what it does and for whom. -->
A Python 3.12 project for AI agents, RAG or document AI on AWS. Library layout: code in `src/app/`,
offline tests in `tests/`.

## Repo layout

```text
src/app/              config.py (settings from env); the project's code goes here
tests/                Offline tests: no AWS, no model calls, no database
.devcontainer/        Python 3.12, uv, AWS CLI v2, Docker-in-Docker, gh, Claude Code
.vscode/settings.json Editor settings (formatters, format on save)
compose.yaml          Local Postgres + pgvector (`make db-up`), for projects that need it
```

## Design rules

- **Model is config, not code:** `MODEL_PROVIDER` (`bedrock` | `openrouter`) and `MODEL_ID`.
  No code depends on a specific model.
- **Deterministic work stays in code:** arithmetic, checks and parsing run in Python; use an agent or
  model call only where judgement is needed.
- **Dependencies:** add with `uv add <pkg>` (`uv add --dev` for tools). `pyproject.toml` lists them,
  `uv.lock` pins them; commit both. Add what the project needs, not what it might need.
- **No keys in code or repo.** Local values in `.env.local` (git-ignored); deployed secrets in a secret
  store. `.env.example` lists every setting with empty values.
- **Data:** downloaded or generated data lives in `data/` and is never committed; ship a script instead.

## Environment

- AWS CLI profile `sandbox`, region `eu-central-1`, both set by the dev container. Log in inside the
  container with `make sso-login`. Use no other profile or region.
- Docker runs inside the dev container (Docker-in-Docker); it cannot see the host's containers.

## Working rules

- `make check typecheck test` must pass before every commit. Tests stay offline.
- Pre-commit hooks run on every commit (ruff, shell checks, gitleaks). Don't skip them with
  `--no-verify`; fix the finding.
- One branch per change, cut from `main` and merged by PR.
- Never push, deploy or destroy cloud resources without asking.
- Don't add features beyond the agreed step without asking.
- Keep answers and docs honest: say what was measured and what was assumed.
