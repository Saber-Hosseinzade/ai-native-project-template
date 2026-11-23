# Project name

One or two sentences: what this project does and for whom.

> **Status:** scaffold.

## Stack

Python 3.12 · uv · Amazon Bedrock (default) or OpenRouter · PostgreSQL + pgvector (optional, local via Docker)

## Run locally

Open the folder in the dev container (VS Code: *Reopen in Container*), then:

```bash
cp .env.example .env.local   # fill in what you need
make test                    # offline tests
make db-up                   # Postgres + pgvector, if the project uses it
```

## Configuration

The model is configuration, not code: set `MODEL_PROVIDER` (`bedrock` or `openrouter`) and `MODEL_ID` in `.env.local`. See `.env.example` for every setting.

## Development

| Command | What it does |
| --- | --- |
| `make test` | Offline tests: no AWS, no model calls, no database |
| `make lint` / `make fmt` | Ruff check / fix |
| `make install` | Install what `uv.lock` pins |
| `make help` | All targets |

Dependencies are listed in `pyproject.toml` only; run `uv lock` after changing them.

## License

MIT
