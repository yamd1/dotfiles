#!/usr/bin/env bash
# セッション終了時に会話をQA形式でkiokuに保存する

set -euo pipefail

KIOKU="${HOME}/.local/bin/kioku"
if [[ ! -x "$KIOKU" ]]; then
  exit 0
fi

# stdin から session_id を取得
input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // empty' 2>/dev/null)
if [[ -z "$session_id" ]]; then
  exit 0
fi

# トランスクリプトのパスを構築
# PWD の先頭 / を除去して / を - に変換
cwd_slug=$(echo "$PWD" | tr '/.' '-')
transcript="${HOME}/.claude/projects/${cwd_slug}/${session_id}.jsonl"
if [[ ! -f "$transcript" ]]; then
  exit 0
fi

# user/assistant メッセージをQA形式に整形
qa=$(python3 - "$transcript" <<'PYEOF'
import sys, json

path = sys.argv[1]
pairs = []
current_q = None

with open(path) as f:
    for line in f:
        try:
            obj = json.loads(line)
        except json.JSONDecodeError:
            continue

        t = obj.get("type")
        if t not in ("user", "assistant"):
            continue

        msg = obj.get("message", {})
        role = msg.get("role", t)
        content = msg.get("content", "")

        # content がリストの場合はテキストブロックだけ結合
        if isinstance(content, list):
            parts = []
            for block in content:
                if isinstance(block, dict) and block.get("type") == "text":
                    parts.append(block["text"])
            content = "\n".join(parts)

        content = content.strip()
        if not content:
            continue

        if role == "user":
            current_q = content
        elif role == "assistant" and current_q is not None:
            pairs.append((current_q, content))
            current_q = None

if not pairs:
    sys.exit(1)

lines = []
for q, a in pairs:
    lines.append(f"Q: {q}")
    lines.append(f"A: {a}")
    lines.append("")

print("\n".join(lines).strip())
PYEOF
)

if [[ -z "$qa" ]]; then
  exit 0
fi

date_tag=$(date +%Y-%m-%d)
echo "$qa" | "$KIOKU" add \
  --source "session:${session_id}" \
  --tags "session,${date_tag},${cwd_slug}" \
  2>/dev/null || true
