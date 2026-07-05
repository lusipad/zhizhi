# Implementation Notes

No matter how much planning happened, unknown unknowns lurk in the code. Notes turn them
from silent improvisation into a record. Embed these instructions in the plan's handoff
so the implementing session follows them.

## Setup

At the start of implementation, create `implementation-notes.md` in the repo root (or
`docs/` if the project keeps working documents there):

```markdown
# Implementation notes — <task name>
Plan: <link/path to the plan>

## Decisions
## Deviations
## Surprises
## Questions for review
```

## Rules during implementation

1. **Log as you go, not at the end.** An entry written two hours later loses the reason.
2. Every entry gets a file/line reference where applicable.
3. **On an edge case that forces deviating from the plan: pick the conservative option,
   log it under Deviations, keep going.** Conservative = reversible, minimal blast
   radius, closest to the plan's intent. Don't stall the task on a judgment call the
   notes can carry to review.
4. Stop and ask only for what the plan's deviation policy reserved: destructive actions,
   security surface, or a discovery that invalidates the plan's premise.
5. **Re-diagnosis trigger:** when the third entry lands under Deviations, or a single
   Surprise contradicts one of the plan's premises, stop patching. Say: "the map has
   drifted from the territory — recommend re-running kickoff on the affected area before
   continuing." A plan whose premises broke doesn't need more deviations logged against
   it; it needs a new diagnosis.

What goes where: **Decisions** — choices the plan left open, and what you picked.
**Deviations** — what the plan said, what you did, why, and the alternative.
**Surprises** — hidden coupling, dead code that isn't, tests asserting the wrong thing.
**Questions for review** — anything needing human judgment.

## At the end of the session

Summarize at the top: what shipped versus what the plan promised, three sentences max.
Point at the two or three entries most worth attention. The wrapup skill consumes this
file.
