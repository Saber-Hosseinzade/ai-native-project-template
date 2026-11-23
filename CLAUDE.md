# CLAUDE.md

Context for AI coding assistants. Personal notes go in `CLAUDE.local.md` (git-ignored).

## What this is

A Python 3.12 project for AI agents, RAG or document AI on AWS. Code in `src/app/`, offline tests in
`tests/`, local Postgres + pgvector in `compose.yaml` (`make db-up`).

## Design rules

- **Model is config, not code:** `MODEL_PROVIDER` (`bedrock` | `openrouter`) and `MODEL_ID`.
- **Deterministic work stays in code;** use a model call only where judgement is needed.
- **Dependencies:** `uv add <pkg>` (`--dev` for tools); commit `pyproject.toml` and `uv.lock` together.
  Add only what the project needs.
- **No keys in code or repo:** local values in `.env.local`; `.env.example` lists every setting, empty.
- **Data** lives in `data/` and is never committed; ship a script that fetches it.

## Environment

AWS profile `sandbox`, region `eu-central-1`, both set by the dev container; log in with
`make sso-login`. Use no other profile or region. Docker runs inside the dev container.

## Development lifecycle

- **Plan:** every change starts as `intent/<date>-<name>/intent.md` (skill `/intent`); see
  `intent/README.md`. Features and non-trivial changes need a merged intent before design or code;
  small fixes and dependency bumps don't.
- **Design:** an accepted intent becomes `spec.md` next to it (skill `/spec`), applying the policy
  skills `security-policy` and `ai-design-standards`. Build starts from a merged spec.

## Working rules

- `make check typecheck test` passes before every commit; tests stay offline.
- Don't skip pre-commit hooks with `--no-verify`; fix the finding.
- One branch per change, merged to `main` by PR.
- Never push, deploy or destroy cloud resources without asking.
- Don't add features beyond the agreed step without asking.
- Say what was measured and what was assumed.
