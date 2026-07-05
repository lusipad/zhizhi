# Brainstorm & Throwaway Prototypes

This technique hunts criteria the user only knows to define when they see them. Finding
them during prototyping is cheap; finding them mid-implementation is expensive — small
spec changes cause drastically different implementations. Make cheap concrete things,
let the user react, turn reactions into explicit criteria.

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
2. Each is a **single self-contained HTML file with fake data**. No backend, no build
   step, no wiring into the real app. Openable by double-click.
3. Write prototypes to a scratch/temp directory, never into the project source tree.
4. Present side by side (a simple index page linking them works well); ask what draws
   the eye, what feels wrong, what's missing.

## Mode C — Feasibility spike ("can this be done at all?")

Distinct from Mode B: taste prototypes ask *what should it look like*; spikes ask *is
this physically possible, accurate enough, fast enough*. Don't conflate them — a
beautiful mockup of an approach that can't work is worse than no mockup.

1. **Define the pass/fail threshold before running the spike** ("transcription must
   place word boundaries within ±50ms on our sample audio"). Deciding the bar after
   seeing results invites rationalizing.
2. Build the smallest experiment that produces a yes/no answer with evidence — a script
   against real sample data beats a toy demo.
3. Output: **verdict + measured evidence + implications for the approach.** A failed
   spike is the technique succeeding — it just saved the expensive version of the same
   discovery.

## The reaction loop (all modes)

After each round, update a visible list called **Criteria discovered** — every reaction
translated into an explicit, testable criterion ("dense tables over cards", "one primary
action per screen"). Iterate until the user converges.

**The criteria list is the real deliverable, not the prototypes.** Output it in a form
that pastes into the plan.

## Guardrails

- Prototypes are disposable. Never promote prototype code into the real app; the real
  implementation starts from the criteria.
- Don't polish prototypes.
- If a new reaction contradicts an earlier criterion, surface the contradiction instead
  of silently obeying the newest instruction.
