# Premise Challenge

The unknowns framework has a hidden assumption: that your "knowns" are true. The most
expensive failures rarely come from ignorance — they come from **false confidence**:
"sessions are stored in Redis" (migrated away six months ago), "nothing else calls this
endpoint" (a cron job does). This technique falsifies what the user — and you — treat
as fact, before anything gets built on top of it.

## 1. Harvest the premises

Collect every assertion being treated as fact, from three sources:

- **The user's statements** — anything phrased as certainty about the territory:
  "it's stored in X", "this is only used by Y", "we can't change Z"
- **Your own inherited assumptions** — industry defaults you're silently applying that
  this codebase may not follow
- **Constraints stated as immovable** — "we must keep X" sometimes describes a decision
  from two years ago, not a current requirement

## 2. Rank, then verify the dangerous ones

Rank by **damage-if-wrong × cheapness-to-check**. A premise that's cheap to verify and
catastrophic if false gets checked first. Time-box the pass; don't audit trivia whose
falsity wouldn't change any decision.

Verify against the territory, not by asking the user to re-confirm: read the code, run
the query, check the migration history, grep for callers.

## 3. Report the verdicts

One row per premise:

| Premise | Verdict | Evidence | If false, it changes… |
|---|---|---|---|
| "sessions live in Redis" | **FALSE** | `src/session/store.ts:12` — cookie store since #841 | the whole SSO token plan |
| "only mobile calls /v2/sync" | CONFIRMED | grep across repos, API gateway logs | — |
| "peak is ~200 rps" | UNVERIFIABLE | no metrics access | carry into plan as low-confidence assumption |

- **CONFIRMED** needs evidence, not vibes — cite the file, the query, the log.
- **FALSE** premises get surfaced immediately and loudly. If one invalidates the task's
  framing, say so before any other work continues — that's this technique's best outcome.
- **UNVERIFIABLE** premises don't get silently trusted: they move into the plan's
  assumptions section with low confidence and an explicit "what would flip it".

## Guardrails

- Challenge premises whose falsity would change decisions; skip pedantry.
- Your own confidence is in scope: if you catch yourself about to write "obviously" or
  "typically", that sentence probably contains an unverified premise.
