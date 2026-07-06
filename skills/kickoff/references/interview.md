# Interview

Extract the decisions hiding in the user's head — one question at a time, biggest blast
radius first.

**Language:** templates and section names in this file are the spec, not literal output —
render everything user-facing in the user's language. Code identifiers, file paths, and
anchor tokens (CONFIRMED / FALSE / UNVERIFIABLE, PASS / NOT YET, notes headings) stay in
English.

## 1. Prepare (silently)

Build a private list of every ambiguity from the task, plan drafts, criteria, and code.
Sort by blast radius:

1. **Architecture** — answers that change structure, dependencies, or data flow
2. **Data model** — schemas, types, persistence, migrations
3. **Behavior & UX flows** — edge case policy, error handling
4. **Surface polish** — naming, copy, layout

Discard questions the territory already answers. Never ask what you can look up. Facts
you *can't* look up (unreachable systems, what a teammate actually observed) are fair
material — flag them as verification, not decisions, and prefer asking for command
output over recollection.

## 2. Interview

- **Say how long the tunnel is.** Open with the expected count ("about six questions,
  biggest first") and update it if answers change the list — an interview with no
  visible end feels like ceremony, and gets abandoned.
- **One question per turn.** Never dump a list.
- Each question carries: the question, **why it matters** (one sentence), and **a
  suggested default** so the user can just reply "default".
- Follow the thread: if an answer opens a bigger ambiguity, pursue it first.
- Pivot signal: if an answer implies the problem should be solved differently
  altogether, stop and say so.

Stop when remaining questions would no longer change any decision — typically 5–9 — or
when the user says stop. Don't pad; don't cut short.

## 3. Deliver the decision log

1. **Decision log** — table: question → decision → implication for implementation
2. **Assumptions adopted** — defaults accepted without discussion, flagged for revisit
3. **Still open** — anything deferred, with what it blocks

Format for direct pasting into the plan.

## Guardrails

- Don't re-ask what the user already said — quote it back if you need confirmation.
- If the user answers "I don't know" twice on the same topic, that topic needs
  brainstorm, blindspot, or a diagnostic spike — whichever hasn't run yet — not more
  pressure.
