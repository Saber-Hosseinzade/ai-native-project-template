# Intent

Every change starts here as a short `intent.md`: what is wanted, why, and under which constraints.
It is written before any design or code, and the code derived from it lives in the same repo.

## Layout

One folder per change, named `YYYY-MM-DD-short-name/`. The design stage adds its `spec.md` next to the
intent later.

```text
intent/
  _template.md
  2026-11-23-example-change/
    intent.md
```

## Flow

1. Describe the problem to Claude in your own words (`/intent`, or ask for a new intent).
2. Claude asks the questions an analyst would: scope, users, constraints, what success looks like.
3. Claude writes `intent.md` from `_template.md`, with `Status: draft`.
4. Correct anything Claude misunderstood.
5. Commit it on a branch `intent/<short-name>` and open a pull request.
   **Merged = accepted** into design; **closed = rejected**. The Git history keeps author and dates.

## Measure

- Time from the first conversation to the committed `intent.md` (Git history).
- Share of intents merged rather than closed.
- Edits to an `intent.md` after its `spec.md` was first committed: fewer means clearer intent.
