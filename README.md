<div align="center">

# Unknown Unknowns

**`kickoff` when you start &nbsp;·&nbsp; `wrapup` when you finish &nbsp;·&nbsp; `quiz-me` when you're not sure**

Three commands that find what you don't know you don't know — before it gets expensive.

[![Agent Skills](https://img.shields.io/badge/Agent_Skills-compatible-4B8BBE)](https://agentskills.io)
[![Claude Code](https://img.shields.io/badge/Claude_Code-plugin-D97757)](#claude-code)
[![Codex CLI](https://img.shields.io/badge/Codex_CLI-supported-10A37F)](#openai-codex-cli)
[![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey)](./LICENSE)

**English** · [中文](./README.zh-CN.md)

</div>

---

## The problem

Your prompt is a map. The codebase — with its history, conventions, and half-finished
adapters — is the territory. Wherever they differ, the agent guesses. The more work you
delegate, the more it guesses.

The obvious fix is "know your unknowns." But there's a paradox: **the person who most
needs to find their blind spots is, by definition, the person who doesn't know they have
them.** You'll never think "I have unknown knowns right now, better run the technique
for that."

So this toolkit doesn't ship a taxonomy to memorize. It ships **three moments you
already feel**:

## Three moments

### 🔍 `kickoff` — "I'm about to start"

Diagnoses your unknowns, then runs **only** the techniques that fire — a blind spot
briefing for unfamiliar territory, throwaway prototypes when you'll *know it when you
see it*, a one-question-at-a-time interview for open decisions, semantics extraction
from a reference — landing on a plan you can review in five minutes.

```text
You:    /kickoff add SSO — I've never touched this app's auth module

Agent:  Two signals fired: unfamiliar territory, open decisions.
        Blind spot pass on src/auth first…

        · There's a half-finished OIDC adapter (PR #142, abandoned) — reuse or replace?
        · Sessions live in signed cookies; SSO tokens won't fit. Decision needed.
        · Question you didn't know to ask: which of the three login flows does SSO replace?

        Interviewing you next — one question at a time, architecture first.
```

If nothing fires, it says **"no meaningful unknowns — just implement"** and gets out of
the way. Kickoff is a diagnosis, not a ceremony.

### 📦 `wrapup` — "I just finished"

Packages the work into a buy-in doc that leads with the demo and answers reviewers'
objections up front. Then quizzes you on what actually changed — including the existing
code paths diffs never show — and only recommends merging on a full pass. Finally,
banks the session's surprises into permanent context.

### 🎯 `quiz-me` — "I'm not sure I understand this change"

The quiz alone: explain, test, grade strictly. Ends with an explicit
**PASS — safe to merge** or **NOT YET — misses on: <topics>**. Never softened, so you
can trust a PASS.

## The loop

```mermaid
flowchart LR
    K["🔍 kickoff"] --> P["unknowns-first plan"]
    P --> I["implement<br/><i>fresh session, deviations logged</i>"]
    I --> W["📦 wrapup"]
    W -. "learnings promoted to<br/>CLAUDE.md / AGENTS.md" .-> K
```

What you learn becomes the map for next time.

## What's inside

The nine techniques from Thariq's
[*A Field Guide to Fable: Finding Your Unknowns*](https://x.com/trq212/article/2073100352921215386)
are all here — as the agent's internal toolbox (`references/` in each skill), loaded
only when needed. You never have to name them:

| You say… | Kickoff reaches for |
|---|---|
| "I've never touched this part of the codebase" | Blind spot pass |
| "Show me options — I'll know it when I see it" | Brainstorm & throwaway prototypes |
| "There are decisions I haven't made" | One-question-at-a-time interview |
| "Make it work like this library" | Reference semantics extraction |
| "OK, ready to build" | Unknowns-first plan + implementation notes |

## Install

#### Claude Code

```
/plugin marketplace add lusipad/Unknown-unknowns
/plugin install unknown-unknowns@unknown-unknowns
```

#### OpenAI Codex CLI

```sh
git clone https://github.com/lusipad/Unknown-unknowns.git
cd Unknown-unknowns && ./install.sh --codex
```

Windows: `.\install.ps1 -Codex`

#### Universal (Claude Code + Codex + Cursor + more)

```sh
npx skills add lusipad/Unknown-unknowns
```

#### Manual

Each skill is a plain folder with a `SKILL.md`. Copy any folder from `skills/` into
your agent's skills directory (`~/.claude/skills/`, `~/.codex/skills/`, …).

### Optional: three always-on rules

Two things nobody remembers to trigger: keeping implementation notes mid-task, and
reviewing before merge. Opt in per project:

```sh
./install.sh --rules /path/to/your/project    # Windows: .\install.ps1 -Rules D:\your\project
```

Appends [three lines](./rules/unknowns-rules.md) to the project's
`CLAUDE.md` / `AGENTS.md` (idempotent — safe to re-run).

## Multilingual

Instructions stay in English (best model adherence), but every skill requires
user-facing output — briefings, questions, quizzes, verdicts — **in the language you're
speaking**. Triggering works in any language via semantic matching; 中文 trigger words
(开工 / 收工 / 考考我) are built into the descriptions.

## Design principles

- **Moments, not taxonomy.** People reliably feel *starting* and *finishing*; they don't
  reliably notice "I have unknown knowns." Commands map to the former; the agent handles
  the latter.
- **Progressive disclosure.** Three entry points; nine techniques as reference files
  read on demand — cheap on context until needed.
- **Portable by construction.** Frontmatter is only `name` + `description` (the open
  [Agent Skills](https://agentskills.io) format); bodies contain no agent-specific tool
  names.
- **Honest exits.** "Just implement" and "NOT YET" are first-class outcomes, not
  failures.

## Credits & license

Concepts from [Thariq (@trq212)](https://x.com/trq212)'s
[*A Field Guide to Fable: Finding Your Unknowns*](https://x.com/trq212/article/2073100352921215386).
MIT — see [LICENSE](./LICENSE).
