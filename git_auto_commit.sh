#!/usr/bin/env bash
# =============================================================================
#  git-autocommit.sh — Automate Git commits with custom messages
# =============================================================================
#
#  USAGE:
#    ./git-autocommit.sh [OPTIONS] [FILES...]
#
#  OPTIONS:
#    -m  <message>     Commit message (required unless -a is used)
#    -a                Auto-generate message from changed file names
#    -p                Push to remote after committing
#    -b  <branch>      Push to a specific branch (default: current branch)
#    -t  <tag>         Create an annotated tag after committing
#    -w  <seconds>     Watch mode: auto-commit every N seconds
#    -d  <directory>   Target Git repo directory (default: current dir)
#    -n                Dry run — show what would happen without doing it
#    -q                Quiet mode — suppress non-error output
#    -h                Show this help message
#
#  EXAMPLES:
#    ./git-autocommit.sh -m "fix: resolve login bug"
#    ./git-autocommit.sh -m "feat: add dashboard" -p
#    ./git-autocommit.sh -m "docs: update README" src/README.md
#    ./git-autocommit.sh -a -p -b main
#    ./git-autocommit.sh -m "chore: nightly save" -w 300
#    ./git-autocommit.sh -m "release: v1.2.0" -t v1.2.0 -p
#    ./git-autocommit.sh -m "wip: testing" -n
# =============================================================================

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

# ── Defaults ──────────────────────────────────────────────────────────────────
MESSAGE=""
AUTO_MSG=false
PUSH=false
BRANCH=""
TAG=""
WATCH=0
REPO_DIR="$(pwd)"
DRY_RUN=false
QUIET=false
FILES=()

# ── Helpers ───────────────────────────────────────────────────────────────────
info()    { $QUIET || echo -e "${CYAN}[INFO]${RESET}  $*"; }
success() { $QUIET || echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*" >&2; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
die()     { error "$*"; exit 1; }

show_help() {
  sed -n '3,29p' "$0" | sed 's/^#  \?//'
  exit 0
}

# ── Parse arguments ───────────────────────────────────────────────────────────
while getopts ":m:apb:t:w:d:nqh" opt; do
  case $opt in
    m) MESSAGE="$OPTARG" ;;
    a) AUTO_MSG=true ;;
    p) PUSH=true ;;
    b) BRANCH="$OPTARG" ;;
    t) TAG="$OPTARG" ;;
    w) WATCH="$OPTARG" ;;
    d) REPO_DIR="$OPTARG" ;;
    n) DRY_RUN=true ;;
    q) QUIET=true ;;
    h) show_help ;;
    :) die "Option -$OPTARG requires an argument." ;;
    \?) die "Unknown option: -$OPTARG. Use -h for help." ;;
  esac
done
shift $((OPTIND - 1))
FILES=("$@")   # remaining args are specific files to stage

# ── Validation ────────────────────────────────────────────────────────────────
[[ -d "$REPO_DIR/.git" ]] || die "'$REPO_DIR' is not a Git repository."
cd "$REPO_DIR"

if ! $AUTO_MSG && [[ -z "$MESSAGE" ]]; then
  die "Commit message required. Use -m \"your message\" or -a for auto-message."
fi

if [[ -n "$WATCH" && "$WATCH" -lt 0 ]]; then
  die "Watch interval must be a positive integer."
fi

# ── Core commit logic ─────────────────────────────────────────────────────────
do_commit() {
  # 1. Determine what to stage
  if [[ ${#FILES[@]} -gt 0 ]]; then
    info "Staging specified files: ${FILES[*]}"
    $DRY_RUN || git add "${FILES[@]}"
  else
    info "Staging all changes (git add -A)"
    $DRY_RUN || git add -A
  fi

  # 2. Check for anything to commit
  if ! $DRY_RUN && git diff --cached --quiet; then
    warn "Nothing to commit — working tree clean."
    return 0
  fi

  # 3. Build commit message
  local msg="$MESSAGE"
  if $AUTO_MSG; then
    local changed
    changed=$(git diff --cached --name-only 2>/dev/null | head -5 | paste -sd ', ')
    msg="${changed:-auto-commit}: $(date '+%Y-%m-%d %H:%M:%S')"
  fi

  # 4. Append timestamp footer
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S %Z')
  local full_msg="$msg

Auto-committed: $timestamp
Host: $(hostname)"

  info "Commit message: ${BOLD}$msg${RESET}"

  if $DRY_RUN; then
    echo -e "${YELLOW}[DRY-RUN]${RESET} Would commit with: \"$msg\""
  else
    git commit -m "$full_msg"
    success "Committed: $msg"
  fi

  # 5. Optional tag
  if [[ -n "$TAG" ]]; then
    info "Creating tag: $TAG"
    if $DRY_RUN; then
      echo -e "${YELLOW}[DRY-RUN]${RESET} Would tag: $TAG"
    else
      git tag -a "$TAG" -m "Tagged by git-autocommit: $TAG"
      success "Tag created: $TAG"
    fi
  fi

  # 6. Optional push
  if $PUSH; then
    local remote_branch="${BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"
    info "Pushing to origin/$remote_branch ..."
    if $DRY_RUN; then
      echo -e "${YELLOW}[DRY-RUN]${RESET} Would push to origin/$remote_branch"
    else
      git push origin "$remote_branch"
      [[ -n "$TAG" ]] && git push origin "$TAG"
      success "Pushed to origin/$remote_branch"
    fi
  fi
}

# ── Watch mode vs single-run ──────────────────────────────────────────────────
if [[ "$WATCH" -gt 0 ]]; then
  echo -e "${BOLD}${CYAN}Watch mode ON — committing every ${WATCH}s. Press Ctrl+C to stop.${RESET}"
  while true; do
    echo -e "\n${BOLD}── $(date '+%H:%M:%S') ─────────────────────────────${RESET}"
    do_commit || true   # don't abort watch on "nothing to commit"
    sleep "$WATCH"
  done
else
  do_commit
fi
