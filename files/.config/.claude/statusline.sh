#!/usr/bin/env bash

BLOCKS=( ' ' '▏' '▎' '▍' '▌' '▋' '▊' '▉' '█' )
R=$'\033[0m'
DIM=$'\033[2m'

gradient() {
    local pct=$1
    if awk "BEGIN{exit !($pct < 50)}"; then
        local r
        r=$(awk "BEGIN{printf \"%d\", $pct * 5.1}")
        printf '\033[38;2;%d;200;80m' "$r"
    else
        local g
        g=$(awk "BEGIN{v=200-($pct-50)*4; if(v<0)v=0; printf \"%d\", v}")
        printf '\033[38;2;255;%d;60m' "$g"
    fi
}

bar() {
    local pct width=10 full frac rest b=""
    pct=$(awk "BEGIN{p=$1; if(p<0)p=0; if(p>100)p=100; print p}")
    full=$(awk "BEGIN{printf \"%d\", int($pct * $width / 100)}")
    frac=$(awk "BEGIN{f=$pct*$width/100; printf \"%d\", int((f-int(f))*8)}")

    for ((i=0; i<full; i++)); do b+='█'; done

    if (( full < width )); then
        b+="${BLOCKS[$frac]}"
        rest=$(( width - full - 1 ))
        for ((i=0; i<rest; i++)); do b+='░'; done
    fi
    printf '%s' "$b"
}

fmt() {
    local label=$1 pct=$2 p
    p=$(awk "BEGIN{printf \"%d\", int($pct + 0.5)}")
    printf '%s %s%s %d%%%s' "$label" "$(gradient "$pct")" "$(bar "$pct")" "$p" "$R"
}

json=$(cat)

_get() {
    python3 -c "
import json, sys
d = json.loads(sys.argv[1])
keys = sys.argv[2].split('.')
for k in keys:
    if isinstance(d, dict): d = d.get(k)
    else: d = None
    if d is None: break
print(d if d is not None else '')
" "$json" "$1"
}

model=$(_get "model.display_name")
[[ -z "$model" ]] && model="Claude"
parts=("$model")

ctx=$(_get "context_window.used_percentage")
[[ -n "$ctx" ]] && parts+=("$(fmt 'ctx' "$ctx")")

five=$(_get "rate_limits.five_hour.used_percentage")
[[ -n "$five" ]] && parts+=("$(fmt '5h' "$five")")

week=$(_get "rate_limits.seven_day.used_percentage")
[[ -n "$week" ]] && parts+=("$(fmt '7d' "$week")")

sep="${DIM}│${R}"
out=""
for i in "${!parts[@]}"; do
    [[ $i -eq 0 ]] && out=" ${parts[$i]} " || out+="${sep} ${parts[$i]} "
done
printf '%s' "$out"
