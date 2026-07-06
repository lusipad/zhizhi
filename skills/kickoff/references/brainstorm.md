# Brainstorm & Throwaway Prototypes

This technique hunts criteria the user only knows to define when they see them. Finding
them during prototyping is cheap; finding them mid-implementation is expensive — small
spec changes cause drastically different implementations. Make cheap concrete things,
let the user react, turn reactions into explicit criteria.

**Language:** templates and section names in this file are the spec, not literal output —
render everything user-facing in the user's language. Code identifiers, file paths, and
anchor tokens (CONFIRMED / FALSE / UNVERIFIABLE, PASS / NOT YET, notes headings) stay in
English.

## Mode A — Approach brainstorm (strategy, architecture, product)

1. Restate the problem in one paragraph; list known constraints.
2. Search the codebase and/or web for context that changes the option space.
3. Generate **5–10 distinct approaches, ordered cheapest to most ambitious.** Each gets:
   one-line description, core tradeoff, rough cost (hours / days / week+). Include at
   least one approach that reframes the problem instead of solving it as posed.
4. Ask which ones resonate. Don't pick for the user — the reactions are the point.

## Mode B — Prototype (visual, UX, anything "I'll know it when I see it")

1. Build **3–4 wildly different directions**, not four variations of one idea. If they'd
   all get the same one-word label ("minimal"), they're not different enough.
2. Each is a **single self-contained HTML file with fake data in the user's language** —
   taste reactions to English placeholder text don't transfer, especially typography and
   density. No backend, no build step, no wiring into the real app.
3. Write prototypes somewhere the user can actually open and that outlives the turn —
   never the project source tree. On a remote or sandboxed host, a gitignored
   `prototypes/` folder in the repo, with the exact paths to open in a browser.
4. Present side by side (a simple index page linking them works well); ask what draws
   the eye, what feels wrong, what's missing.

## Mode C — Feasibility spike ("can this be done at all — or why does it keep failing?")

Distinct from Mode B: taste prototypes ask *what should it look like*; spikes ask *is
this physically possible, accurate enough, fast enough* — or, for diagnostic work,
*which hypothesis about the failure survives an experiment*. Don't conflate them — a
beautiful mockup of an approach that can't work is worse than no mockup.

1. **Define the pass/fail threshold before running the spike** ("transcription must
   place word boundaries within ±50ms on our sample audio"). Deciding the bar after
   seeing results invites rationalizing. If the threshold is itself an undecided
   question ("how fast is fast enough?"), ask that single interview question early,
   out of order, before running the spike.
2. Build the smallest experiment that produces a yes/no answer with evidence — a script
   against real sample data beats a toy demo. If the spike needs an environment you
   can't reach, deliver a runnable script plus the pre-committed bar for the user to
   execute and report.
3. Output: **verdict + measured evidence + implications for the approach.** A failed
   spike is the technique succeeding — it just saved the expensive version of the same
   discovery.

## The reaction loop (all modes)

After each round, update a visible list called **Criteria discovered** — every reaction
translated into an explicit, testable criterion ("dense tables over cards", "one primary
action per screen"). Default to two reaction rounds; ask before a third.

**The criteria list is the real deliverable, not the prototypes.** Output it in a form
that pastes into the plan.

## Guardrails

- Prototypes are disposable. Never promote prototype code into the real app; the real
  implementation starts from the criteria.
- Don't polish prototypes.
- If a new reaction contradicts an earlier criterion, surface the contradiction instead
  of silently obeying the newest instruction.
