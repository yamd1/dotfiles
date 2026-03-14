#!/bin/bash
# Claude Code が stdin に送信する JSON データを読み取る
input=$(cat)

# jq を使用してフィールドを抽出する
MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# "// 0" はフィールドが null の場合のフォールバックを提供します
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# ステータスラインを出力します - ${DIR##*/} はフォルダ名のみを抽出します
echo "[$MODEL] 📁 ${DIR##*/} | ${PCT}% context"
