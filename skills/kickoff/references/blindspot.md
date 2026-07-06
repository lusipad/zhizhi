# Blind Spot Pass

The user is about to work somewhere they can't see clearly. They may not know what
questions to ask, what good looks like, what historical work exists, or what potholes to
avoid. Explore the territory for them and hand back a map.

**This technique teaches; it never implements.**

**Language:** templates and section names in this file are the spec, not literal output —
render everything user-facing in the user's language. Code identifiers, file paths, and
anchor tokens (CONFIRMED / FALSE / UNVERIFIABLE, PASS / NOT YET, notes headings) stay in
English.

## 1. Collect the starting point

Three things (ask once, briefly, only for what's missing): what they're about to do,
what they already know, and what decisions they think they'll face. If kickoff Step 1
already collected this, reuse it — fill at most the single missing item; don't re-ask. The gap between what
they think the task involves and what it actually involves is exactly what you're hunting.

## 2. Explore the territory

For codebase work: the modules they'll touch and what those depend on; conventions this
area follows that the rest of the codebase doesn't; history (past attempts, reverted
commits, TODO/FIXME, related PRs); what tests cover and conspicuously don't; hidden
coupling. For domain work, pull from web search and your own knowledge: the standard
tooling landscape, published failure modes and post-mortems, the decisions experts
front-load, and their quality bar. Where territory is unreachable (production systems,
third parties), the briefing's "questions you didn't know to ask" must include the
concrete checks the user should run there.

**Budget the exploration.** Breadth first — file names, signatures, commit titles — and
open whole files only when a signal points there. You're drawing a map, not auditing;
this session still has an interview and a plan to fit after you. Where the host supports
subagents, send them exploring and keep only their conclusions.

## 3. Deliver the briefing

Exactly these sections, each tight:

1. **The territory** — what this area/domain actually is, in the user's terms
2. **Questions you didn't know to ask** — the heart of the pass; each with why it
   matters and what the answer changes
3. **Potholes** — specific traps, with file references or concrete examples
4. **Prior art** — what already exists that they should reuse or not contradict
5. **What good looks like** — how an expert judges the result; give them a quality bar
6. **Vocabulary** — terms they'll need to prompt precisely

A section that would be empty for this user gets one line saying so, not filler.

## 4. Help them prompt better

End with **"How to prompt me next"**: their original request rewritten with resolved
assumptions inline and open questions flagged. Decisions only the user can make go to
the interview technique next. Skip this section when other techniques are still queued
in this kickoff — the final handoff subsumes it.
