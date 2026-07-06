---
name: quiz-me
description: Quiz-me (考考我) — after a large change, generates a report explaining the context, intuition, and mechanics of what changed — then quizzes the user on it and grades the answers. Recommends merging only when the user passes completely. Use when the user says "quiz me", "考考我", "测测我", "我不放心这次改动", "do I actually understand this change", "explain what happened then test me", or after a long working session before merge.
---

# Quiz Me

After a long session, more happened than the user realizes. Reading diffs gives only a
light understanding, because much of the new behavior depends on **existing code paths
the diff never shows**. This skill closes that gap: explain, then verify the explanation
landed. The user merges only after passing.

**Language:** write the report, quiz questions, and verdicts in the language the user is
speaking. File names and code identifiers stay in English.

## Step 1 — Scope what "the change" really is

Don't stop at the diff:

- The diff itself
- The existing code paths the new code calls into or is called from
- Behavior that changed *without its code changing* (a config default now taking
  effect, a caller now hitting a different branch)
- What the change relies on continuing to be true (invariants, ordering, formats)

## Step 2 — Write the report

Sections, in order:

1. **Why** — the problem this change solves, one paragraph
2. **Mental model** — the intuition: how to think about the new behavior in one diagram
   or metaphor. If the user keeps one idea, it's this one.
3. **What changed** — a guided walk through the diff, grouped by intent rather than by
   file
4. **What it stands on** — the pre-existing code paths and invariants the change depends
   on; the part diffs never show
5. **Where it could break** — the inputs, states, or future edits most likely to hurt it

Default to Markdown. If the user asks for HTML (or the change is big enough that
navigation helps), produce a single self-contained HTML file with the quiz at the bottom.

Write the report to a file, not only into chat — grading spans multiple turns, and the
report is the answer key; it must survive context compaction. Put it where the project
keeps working documents (or a scratch directory), never loose in the source tree.

## Step 3 — Quiz

5–8 questions at the bottom of the report. Must include at least one of each:

- A question about behavior that depends on **pre-existing code** (not visible in diff)
- A **failure mode**: "what happens if <input/state X>?"
- A **tracing** question: "a request comes in with Y — walk me through what runs"
- A **design** question: "why was alternative Z not used?"

Format for low friction — a quiz nobody takes verifies nothing:

- **Default to multiple choice** (at least two-thirds of the questions), with
  distractors built from plausible misconceptions, not filler. A user who actually
  holds the misconception must find its distractor attractive.
- **At most one or two short-answer questions** (the tracing question is usually the
  one), answerable in a handful of keywords or arrows — say so explicitly.
- Number questions and letter the options so the whole quiz can be answered in one
  line ("1B 2A 3C"). If the host provides a structured choice UI, use it.
- No trivia — every question's answer should matter for operating or reviewing this
  code.

## Step 4 — Grade strictly

- Grade each answer; partial credit is a fail for that question. For short answers,
  judge the concept, not the prose — terse keyword answers are fine.
- For each miss: re-explain with a file/line reference, then ask a **variant** of the
  question (not the same one — the user can echo, that's not understanding).
- Repeat until everything passes — or the user stops. Stopping early is always allowed
  and always a NOT YET, never a reluctant PASS.

End with an explicit verdict:

- **PASS — you understand this change; safe to merge from an understanding standpoint.**
- **NOT YET — misses on: <topics>. Re-quiz when ready.**

Never soften the verdict. The whole value of the skill is that the user can trust a PASS.
