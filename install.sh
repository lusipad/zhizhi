#!/usr/bin/env sh
# Install zhizhi skills for OpenAI Codex CLI and/or Claude Code.
#
# Usage:
#   ./install.sh                     # install for every agent found on this machine
#   ./install.sh --codex             # Codex CLI only  (-> $CODEX_HOME/skills, default ~/.codex/skills)
#   ./install.sh --claude            # Claude Code only (-> ~/.claude/skills)
#   ./install.sh --rules <project>   # also deliver the 3 always-on rules to that
#                                    # project: CLAUDE.md / AGENTS.md append, plus
#                                    # native .cursor/rules and .windsurf/rules files
#                                    # when those dirs exist (idempotent)
#
# Claude Code users can skip this script entirely and use the plugin marketplace:
#   /plugin marketplace add lusipad/zhizhi
#   /plugin install zhizhi@zhizhi

set -e

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$REPO_DIR/skills"
RULES="$REPO_DIR/rules/unknowns-rules.md"
RULES_MARKER="## Finding your unknowns"

CODEX_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
CLAUDE_DIR="$HOME/.claude/skills"

do_codex=0
do_claude=0
explicit=0
rules_dir=""

while [ $# -gt 0 ]; do
  case "$1" in
    --codex)  do_codex=1; explicit=1 ;;
    --claude) do_claude=1; explicit=1 ;;
    --rules)
      shift
      [ $# -gt 0 ] || { echo "--rules needs a project directory" >&2; exit 1; }
      rules_dir="$1"
      ;;
    *)
      echo "Unknown option: $1 (use --codex, --claude, --rules <dir>)" >&2
      exit 1
      ;;
  esac
  shift
done

if [ "$explicit" = 0 ]; then
  [ -d "${CODEX_HOME:-$HOME/.codex}" ] && do_codex=1
  [ -d "$HOME/.claude" ] && do_claude=1
  if [ "$do_codex" = 0 ] && [ "$do_claude" = 0 ] && [ -z "$rules_dir" ]; then
    echo "Neither ~/.codex nor ~/.claude found. Use --codex or --claude to force a target." >&2
    exit 1
  fi
fi

install_to() {
  target="$1"
  mkdir -p "$target"
  count=0
  for skill in "$SRC"/*/; do
    name=$(basename "$skill")
    rm -rf "$target/$name"
    cp -R "$skill" "$target/$name"
    count=$((count + 1))
  done
  echo "Installed $count skills to $target"
}

append_rules() {
  proj="$1"
  [ -d "$proj" ] || { echo "Not a directory: $proj" >&2; exit 1; }
  wrote=0
  for f in CLAUDE.md AGENTS.md; do
    target="$proj/$f"
    if [ -f "$target" ]; then
      if grep -q "$RULES_MARKER" "$target"; then
        echo "Rules already present in $target"
      else
        printf '\n' >> "$target"
        cat "$RULES" >> "$target"
        echo "Appended rules to $target"
      fi
      wrote=1
    fi
  done
  if [ "$wrote" = 0 ]; then
    cat "$RULES" > "$proj/AGENTS.md"
    echo "Created $proj/AGENTS.md with rules (Claude Code users: consider copying into CLAUDE.md)"
  fi

  # Host-native rule files, generated from the one canonical file — no copies to drift.
  if [ -d "$proj/.cursor" ]; then
    mkdir -p "$proj/.cursor/rules"
    {
      printf -- '---\ndescription: zhizhi (知之) always-on rules — notes during work, kickoff after failed attempts, wrapup before merge\nalwaysApply: true\n---\n\n'
      cat "$RULES"
    } > "$proj/.cursor/rules/zhizhi-unknowns.mdc"
    echo "Wrote $proj/.cursor/rules/zhizhi-unknowns.mdc"
  fi
  if [ -d "$proj/.windsurf" ]; then
    mkdir -p "$proj/.windsurf/rules"
    {
      printf -- '---\ntrigger: always_on\n---\n\n'
      cat "$RULES"
    } > "$proj/.windsurf/rules/zhizhi-unknowns.md"
    echo "Wrote $proj/.windsurf/rules/zhizhi-unknowns.md"
  fi
}

[ "$do_codex" = 1 ] && install_to "$CODEX_DIR"
[ "$do_claude" = 1 ] && install_to "$CLAUDE_DIR"
[ -n "$rules_dir" ] && append_rules "$rules_dir"

echo "Done. Skills: kickoff (开工), wrapup (收工), quiz-me (考考我)"
