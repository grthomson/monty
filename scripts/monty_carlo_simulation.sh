#!/usr/bin/env bash
set -euo pipefail

# Monte Carlo for Monty Hall (no external input files needed)
# Usage: ./scripts/simulate.sh -n 10000 [--bin ./monty]

LOOPS=3000
BIN=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--loops) LOOPS="${2:?}"; shift 2 ;;
    --bin)      BIN="${2:?}";  shift 2 ;;
    -h|--help)
      cat <<EOF
Usage: $0 [options]
  -n, --loops N   trials per strategy (default: 3000)
  --bin PATH      path to monty binary (defaults to ./monty)
  -h, --help      show help
EOF
      exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

# Find the binary
if [[ -z "$BIN" ]]; then
  if [[ -x ./monty ]]; then BIN=./monty
  elif [[ -x ./monty.exe ]]; then BIN=./monty.exe
  else
    echo "Error: could not find './monty' — build first (make)." >&2
    exit 1
  fi
fi

# Inputs expected by your program: number then yes/no
INPUT_SWITCH=$'2\ny\n'
INPUT_STAY=$'2\nn\n'

tmpdir="$(mktemp -d -t monty_sim_XXXXXX)"
trap 'rm -rf "$tmpdir"' EXIT
sw_out="$tmpdir/switch.out"
st_out="$tmpdir/stay.out"

# Run trials
for _ in $(seq 1 "$LOOPS"); do
  printf "%s" "$INPUT_SWITCH" | "$BIN" >> "$sw_out"
done
for _ in $(seq 1 "$LOOPS"); do
  printf "%s" "$INPUT_STAY" | "$BIN" >> "$st_out"
done

# Tally wins
wins_switch=$(grep -c "You win the car" "$sw_out" || true)
wins_stay=$(grep -c "You win the car" "$st_out" || true)

pct() { awk -v n="$1" -v d="$2" 'BEGIN{printf (d? "%.2f":"0.00"), (n*100.0)/d}'; }
pct_switch=$(pct "$wins_switch" "$LOOPS")
pct_stay=$(pct "$wins_stay" "$LOOPS")

echo "Trials per strategy: $LOOPS"
echo
echo "Switching wins:     $wins_switch / $LOOPS  (${pct_switch}%)"
echo "Not switching wins: $wins_stay   / $LOOPS  (${pct_stay}%)"

# Optional CSV summary in repo root
summary="simulation_summary.csv"
{
  [[ -s "$summary" ]] || echo "strategy,loops,wins,percent"
  echo "switch,$LOOPS,$wins_switch,$pct_switch"
  echo "stay,$LOOPS,$wins_stay,$pct_stay"
} >> "$summary"
echo "Summary appended to: $summary"
