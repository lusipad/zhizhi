---
name: wrapup
description: Wrapup (收工) — run after implementation work is done, before merging or sharing. Reads the diff, plan, and implementation notes, then produces what the moment needs — a buy-in document that leads with the demo and answers reviewers' objections up front, and a quiz that verifies the user actually understands what changed, recommending merge only on a full pass. Ends by promoting session learnings into permanent context. Use when the user says "wrapup", "收工", "干完了", "I'm done", "package this up", "ready to merge", "get buy-in", or finishes a long working session.
---

# Wrapup

After a long session, more happened than the user realizes — and the people they need
buy-in from start with the same unknowns the user started with. Wrapup closes both gaps,
then banks what was learned.

**Language:** write everything user-facing — the pitch doc, the report, quiz questions,
verdicts — in the language the user is speaking. File names and code identifiers stay in
English.

## Step 1 — Collect what happened

Gather whatever exists: the diff against the base branch, the plan, `implementation-notes.md`
(deviations and surprises are the most valuable material), and demo evidence (screenshots,
GIF, runnable link). For user-facing work with no demo evidence, make some first.

No `implementation-notes.md`? Don't skip what it would have carried: reconstruct the
deviations and surprises from the session history and the diff, and mention once —
not more — that zhizhi's three always-on rules capture these automatically next time
(the README's rules section has the one-liner to install them).

**Mind the context budget** — wrapup runs when the session is at its fullest. Everything
it consumes can live on disk (diff, plan, notes), so with notes on disk it runs fine in
a fresh session — often better. Without notes, the session's memory *is* the evidence:
run wrapup before compaction eats it. Either way, write what you produce to files, not
only chat.

## Step 2 — Produce what the moment needs

Two products. Decide from context, confirm with one short question only if genuinely
unclear:

- **Pitch doc** (read `references/pitch.md`) — when the work needs review, approval, or
  an audience: a single document that leads with the demo, walks the decisions that
  matter, and answers the reviewer's first three questions before they ask. Skip for
  solo throwaway work.
- **Understanding quiz** (read `references/quiz.md`) — a report explaining the change
  including the pre-existing code paths the diff never shows, then a quiz. **Don't skip
  this for any non-trivial change**; it's the only step that verifies the user can
  actually stand behind the merge.

Order: pitch doc first (its material feeds the report), quiz last.

## Step 3 — The gate

Grade the quiz strictly and end with an explicit verdict:

- **PASS — you understand this change; safe to merge from an understanding standpoint.**
- **NOT YET — misses on: <topics>. Re-quiz when ready.**

Never soften the verdict. Its whole value is that the user can trust a PASS.

## Step 4 — Bank the learnings

From the Surprises and Deviations (the notes', or the ones reconstructed in Step 1),
propose which learnings should be **promoted
to permanent context** (CLAUDE.md, AGENTS.md, or team docs) — a surprise that will
surprise the next person too is a documentation bug. Draft the exact lines to add; let
the user say yes or no.

Then close the second loop: for each Surprise and Deviation, ask **"could kickoff have
found this, and why didn't it?"** — a technique that didn't fire, a question the
interview never asked, a premise nobody challenged. Propose one concrete adjustment for
the next kickoff. The first loop improves the map; this one improves the map-making.
