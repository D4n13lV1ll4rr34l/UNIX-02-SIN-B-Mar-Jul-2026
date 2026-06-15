#!/bin/bash

# ============================================================
# exercise2.sh - GitHub Branch Grader for 'blackhatbash'
# Scores a branch from 1 to 100 based on:
#   - Commit time (within class hours 7:00-9:00)
#   - Commit quality & message quality
#   - Language (English = full points, Spanish = half points)
#   - Number of files in the branch
# ============================================================

# ---- CONFIGURATION ----------------------------------------
REPO_OWNER="${1:-}"
REPO_NAME="${2:-}"
BRANCH="${3:-blackhatbash}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

CLASS_START_HOUR=7
CLASS_END_HOUR=9

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ---- USAGE ------------------------------------------------
usage() {
  echo -e "${BOLD}Usage:${RESET} $0 <owner> <repo> [branch]"
  echo ""
  echo "  owner   GitHub username or org (e.g. danielvillarreal)"
  echo "  repo    Repository name        (e.g. unix-bash)"
  echo "  branch  Branch to grade        (default: blackhatbash)"
  echo ""
  echo "  Set GITHUB_TOKEN env var for authenticated requests (avoids rate limits)."
  echo ""
  echo "  Example:"
  echo "    GITHUB_TOKEN=ghp_xxx $0 danielvillarreal unix-bash blackhatbash"
  exit 1
}

[[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]] && usage

# ---- HELPERS ----------------------------------------------
gh_api() {
  local url="https://api.github.com${1}"
  local auth_header=""
  [[ -n "$GITHUB_TOKEN" ]] && auth_header="-H \"Authorization: Bearer ${GITHUB_TOKEN}\""

  if [[ -n "$GITHUB_TOKEN" ]]; then
    curl -sf -H "Authorization: Bearer ${GITHUB_TOKEN}" \
             -H "Accept: application/vnd.github+json" \
             -H "X-GitHub-Api-Version: 2022-11-28" \
             "$url"
  else
    curl -sf -H "Accept: application/vnd.github+json" \
             -H "X-GitHub-Api-Version: 2022-11-28" \
             "$url"
  fi
}

require_cmd() {
  command -v "$1" &>/dev/null || { echo -e "${RED}Error: '$1' is required but not installed.${RESET}"; exit 1; }
}

require_cmd curl
require_cmd jq

# ---- SECTION HEADER ---------------------------------------
print_section() {
  echo ""
  echo -e "${CYAN}${BOLD}━━━ $1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ---- FETCH BRANCH COMMITS ---------------------------------
print_section "Fetching branch: $BRANCH"

COMMITS_JSON=$(gh_api "/repos/${REPO_OWNER}/${REPO_NAME}/commits?sha=${BRANCH}&per_page=100")

if [[ -z "$COMMITS_JSON" || "$COMMITS_JSON" == "null" ]]; then
  echo -e "${RED}Error: Could not fetch commits. Check owner/repo/branch names and token.${RESET}"
  exit 1
fi

TOTAL_COMMITS=$(echo "$COMMITS_JSON" | jq 'length')
echo -e "  Found ${BOLD}${TOTAL_COMMITS}${RESET} commit(s) on branch '${BRANCH}'."

if [[ "$TOTAL_COMMITS" -eq 0 ]]; then
  echo -e "${YELLOW}No commits found. Score: 1/100${RESET}"
  exit 0
fi

# ---- FETCH FILE COUNT -------------------------------------
FILES_JSON=$(gh_api "/repos/${REPO_OWNER}/${REPO_NAME}/git/trees/${BRANCH}?recursive=1")
FILE_COUNT=$(echo "$FILES_JSON" | jq '[.tree[] | select(.type=="blob")] | length')
echo -e "  Found ${BOLD}${FILE_COUNT}${RESET} file(s) in the branch tree."

# ============================================================
# SCORING BREAKDOWN
#
#  A) Commit Time Score      (0-25 pts)
#     All commits within 7:00-9:00  => 25 pts
#     Partial (>=50% on time)        => 12 pts
#     Few/none on time               => 0  pts
#
#  B) Commit Quality Score   (0-30 pts)
#     Meaningful message length (>10 chars) per commit
#     Descriptive keywords presence
#     Scored per-commit, averaged
#
#  C) Language Score         (0-20 pts)
#     All English => 20 pts
#     Mixed       => proportional
#     All Spanish => 10 pts (half credit)
#
#  D) File Count Score       (0-25 pts)
#     1-5   files => 5  pts
#     6-10  files => 12 pts
#     11-20 files => 18 pts
#     21-30 files => 22 pts
#     31+   files => 25 pts
#
# ============================================================

# ---- A) COMMIT TIME SCORE ---------------------------------
print_section "A) Commit Time (class hours ${CLASS_START_HOUR}:00-${CLASS_END_HOUR}:00)"

ON_TIME=0
OFF_TIME=0

while IFS= read -r timestamp; do
  # Extract hour in author's local time (UTC used unless timezone known)
  hour=$(date -d "$timestamp" +"%H" 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%SZ" "$timestamp" +"%H" 2>/dev/null)
  if [[ -n "$hour" ]]; then
    if [[ "$hour" -ge "$CLASS_START_HOUR" && "$hour" -lt "$CLASS_END_HOUR" ]]; then
      ON_TIME=$((ON_TIME + 1))
      echo -e "  ${GREEN}✔${RESET} Commit at ${hour}:xx → within class hours"
    else
      OFF_TIME=$((OFF_TIME + 1))
      echo -e "  ${RED}✘${RESET} Commit at ${hour}:xx → outside class hours"
    fi
  fi
done < <(echo "$COMMITS_JSON" | jq -r '.[].commit.author.date')

TOTAL_TIME_COMMITS=$((ON_TIME + OFF_TIME))
if [[ "$TOTAL_TIME_COMMITS" -gt 0 ]]; then
  RATIO=$(echo "scale=2; $ON_TIME / $TOTAL_TIME_COMMITS" | bc)
else
  RATIO=0
fi

if (( $(echo "$RATIO >= 1.0" | bc -l) )); then
  TIME_SCORE=25
  echo -e "  → All commits on time: ${GREEN}25/25${RESET}"
elif (( $(echo "$RATIO >= 0.5" | bc -l) )); then
  TIME_SCORE=12
  echo -e "  → Most commits on time: ${YELLOW}12/25${RESET}"
else
  TIME_SCORE=0
  echo -e "  → Few/no commits on time: ${RED}0/25${RESET}"
fi

# ---- B) COMMIT QUALITY SCORE ------------------------------
print_section "B) Commit Message Quality"

QUALITY_TOTAL=0
COMMIT_COUNT=0

# Keywords that indicate a descriptive, meaningful commit
GOOD_KEYWORDS=("add" "fix" "update" "create" "implement" "refactor" "remove" "improve" "test" "feat" "agregar" "corregir" "actualizar" "crear" "implementar" "mejorar" "eliminar")

while IFS= read -r msg; do
  COMMIT_COUNT=$((COMMIT_COUNT + 1))
  MSG_LOWER=$(echo "$msg" | tr '[:upper:]' '[:lower:]')
  MSG_LEN=${#msg}
  Q=0

  # Length bonus (max 15 pts per commit)
  if [[ "$MSG_LEN" -ge 40 ]]; then
    Q=15
  elif [[ "$MSG_LEN" -ge 20 ]]; then
    Q=10
  elif [[ "$MSG_LEN" -ge 10 ]]; then
    Q=6
  else
    Q=2
  fi

  # Keyword bonus (up to +10 per commit)
  for kw in "${GOOD_KEYWORDS[@]}"; do
    if echo "$MSG_LOWER" | grep -qi "$kw"; then
      Q=$((Q + 5))
      break
    fi
  done

  # Penalty for generic/auto messages
  if echo "$MSG_LOWER" | grep -qiE "^(initial commit|first commit|update|fix|test|wip|commit|asdf|asd|prueba)$"; then
    Q=$((Q / 2))
    echo -e "  ${YELLOW}~${RESET} Generic message: '${msg}' → partial credit"
  else
    echo -e "  ${GREEN}✔${RESET} Message: '${msg}' (len=${MSG_LEN})"
  fi

  # Cap at 25 per commit
  [[ "$Q" -gt 25 ]] && Q=25
  QUALITY_TOTAL=$((QUALITY_TOTAL + Q))

done < <(echo "$COMMITS_JSON" | jq -r '.[].commit.message | split("\n")[0]')

if [[ "$COMMIT_COUNT" -gt 0 ]]; then
  AVG_QUALITY=$(echo "scale=2; $QUALITY_TOTAL / $COMMIT_COUNT" | bc)
  # Normalize to 30-pt scale (max raw score is 25)
  QUALITY_SCORE=$(echo "scale=0; ($AVG_QUALITY / 25) * 30" | bc)
  [[ "$QUALITY_SCORE" -gt 30 ]] && QUALITY_SCORE=30
  echo -e "  → Average quality: ${AVG_QUALITY}/25 → ${YELLOW}${QUALITY_SCORE}/30${RESET}"
else
  QUALITY_SCORE=0
fi

# ---- C) LANGUAGE SCORE ------------------------------------
print_section "C) Language Detection (English=full, Spanish=half)"

ENGLISH_COUNT=0
SPANISH_COUNT=0
UNKNOWN_COUNT=0

# Spanish indicator words
SPANISH_WORDS=("el " "la " "los " "las " "un " "una " "y " "en " "de " "del " "se " "para " "con " "una " "que " "por " "como " "uso " "linea " "archivo " "bucle " "función" "funcion" "agregar" "crear" "comentario" "añadir" "actualizar" "salida")
ENGLISH_WORDS=("add " "the " "fix " "update " "create " "remove " "initial " "file " "function " "loop " "use " "line " "output " "script " "first " "new " "test " "implement ")

while IFS= read -r msg; do
  MSG_LOWER=$(echo "$msg" | tr '[:upper:]' '[:lower:]')
  SP=0
  EN=0

  for w in "${SPANISH_WORDS[@]}"; do
    echo "$MSG_LOWER" | grep -qi "$w" && SP=$((SP+1))
  done
  for w in "${ENGLISH_WORDS[@]}"; do
    echo "$MSG_LOWER" | grep -qi "$w" && EN=$((EN+1))
  done

  if [[ "$SP" -gt "$EN" ]]; then
    SPANISH_COUNT=$((SPANISH_COUNT+1))
    echo -e "  ${YELLOW}ES${RESET} '${msg}'"
  elif [[ "$EN" -gt 0 ]]; then
    ENGLISH_COUNT=$((ENGLISH_COUNT+1))
    echo -e "  ${GREEN}EN${RESET} '${msg}'"
  else
    UNKNOWN_COUNT=$((UNKNOWN_COUNT+1))
    echo -e "  ${CYAN}??${RESET} '${msg}' (ambiguous)"
  fi
done < <(echo "$COMMITS_JSON" | jq -r '.[].commit.message | split("\n")[0]')

TOTAL_LANG=$((ENGLISH_COUNT + SPANISH_COUNT + UNKNOWN_COUNT))
if [[ "$TOTAL_LANG" -gt 0 ]]; then
  # English = full weight (2), Spanish = half (1), unknown = 1
  LANG_WEIGHTED=$(echo "scale=2; ($ENGLISH_COUNT * 2 + $SPANISH_COUNT * 1 + $UNKNOWN_COUNT * 1) / ($TOTAL_LANG * 2)" | bc)
  LANG_SCORE=$(echo "scale=0; $LANG_WEIGHTED * 20" | bc)
  [[ "$LANG_SCORE" -gt 20 ]] && LANG_SCORE=20
else
  LANG_SCORE=10
fi
echo -e "  EN: ${ENGLISH_COUNT} | ES: ${SPANISH_COUNT} | ??: ${UNKNOWN_COUNT}"
echo -e "  → Language score: ${YELLOW}${LANG_SCORE}/20${RESET}"

# ---- D) FILE COUNT SCORE ----------------------------------
print_section "D) File Count"

echo -e "  Total files: ${BOLD}${FILE_COUNT}${RESET}"

if [[ "$FILE_COUNT" -ge 31 ]]; then
  FILE_SCORE=25
elif [[ "$FILE_COUNT" -ge 21 ]]; then
  FILE_SCORE=22
elif [[ "$FILE_COUNT" -ge 11 ]]; then
  FILE_SCORE=18
elif [[ "$FILE_COUNT" -ge 6 ]]; then
  FILE_SCORE=12
elif [[ "$FILE_COUNT" -ge 1 ]]; then
  FILE_SCORE=5
else
  FILE_SCORE=0
fi
echo -e "  → File score: ${YELLOW}${FILE_SCORE}/25${RESET}"

# ---- FINAL SCORE ------------------------------------------
print_section "FINAL SCORE"

TOTAL_SCORE=$((TIME_SCORE + QUALITY_SCORE + LANG_SCORE + FILE_SCORE))
[[ "$TOTAL_SCORE" -gt 100 ]] && TOTAL_SCORE=100
[[ "$TOTAL_SCORE" -lt 1 ]]   && TOTAL_SCORE=1

echo ""
echo -e "  ${BOLD}Breakdown:${RESET}"
printf "  %-35s %s/25\n"  "A) Commit Timing:"       "$TIME_SCORE"
printf "  %-35s %s/30\n"  "B) Commit Quality:"      "$QUALITY_SCORE"
printf "  %-35s %s/20\n"  "C) Language:"             "$LANG_SCORE"
printf "  %-35s %s/25\n"  "D) File Count:"           "$FILE_SCORE"
echo ""

if [[ "$TOTAL_SCORE" -ge 90 ]]; then
  GRADE_COLOR=$GREEN
  GRADE="Excellent ★★★"
elif [[ "$TOTAL_SCORE" -ge 70 ]]; then
  GRADE_COLOR=$CYAN
  GRADE="Good ★★"
elif [[ "$TOTAL_SCORE" -ge 50 ]]; then
  GRADE_COLOR=$YELLOW
  GRADE="Needs Improvement ★"
else
  GRADE_COLOR=$RED
  GRADE="Insufficient ✗"
fi

echo -e "  ${BOLD}Repository:${RESET}  ${REPO_OWNER}/${REPO_NAME} @ ${BRANCH}"
echo -e "  ${BOLD}Commits:${RESET}     ${TOTAL_COMMITS}"
echo -e "  ${BOLD}Files:${RESET}       ${FILE_COUNT}"
echo ""
echo -e "  ┌─────────────────────────────────┐"
echo -e "  │  FINAL SCORE: ${GRADE_COLOR}${BOLD}${TOTAL_SCORE} / 100${RESET}          │"
echo -e "  │  Grade: ${GRADE_COLOR}${GRADE}${RESET}"
echo -e "  └─────────────────────────────────┘"
echo ""