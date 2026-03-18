#!/bin/bash
# Claude Code PostToolUse hook: AI生成ファイルへの自動フォーマッター適用
# Write/Edit 後に発火。biome > prettier > eslint の優先順で検出して実行。

FILE=$(jq -r '.tool_input.file_path // .tool_response.filePath // empty' 2>/dev/null)

# ファイルパス取得失敗 or ファイル不在 → スキップ
[ -z "$FILE" ] || [ ! -f "$FILE" ] && exit 0

# プロジェクトルートを親ディレクトリを辿って探す
PROJECT_ROOT="$(dirname "$FILE")"
while [ "$PROJECT_ROOT" != "/" ]; do
  [ -f "$PROJECT_ROOT/package.json" ] && break
  PROJECT_ROOT="$(dirname "$PROJECT_ROOT")"
done

# package.json が見つからなければ現在地をルートとする
[ "$PROJECT_ROOT" = "/" ] && PROJECT_ROOT="$(dirname "$FILE")"

# --- biome (最優先) ---
if [ -f "$PROJECT_ROOT/biome.json" ] || [ -f "$PROJECT_ROOT/biome.jsonc" ]; then
  BIOME="$PROJECT_ROOT/node_modules/.bin/biome"
  [ ! -f "$BIOME" ] && command -v biome > /dev/null 2>&1 && BIOME="biome"
  if [ -f "$BIOME" ] || command -v biome > /dev/null 2>&1; then
    ${BIOME:-biome} format --write "$FILE" 2>/dev/null
    exit 0
  fi
fi

# --- prettier ---
HAS_PRETTIER_CFG=false
for cfg in .prettierrc .prettierrc.js .prettierrc.cjs .prettierrc.json \
           .prettierrc.yaml .prettierrc.yml prettier.config.js \
           prettier.config.cjs prettier.config.ts prettier.config.mjs; do
  [ -f "$PROJECT_ROOT/$cfg" ] && HAS_PRETTIER_CFG=true && break
done
# package.json に prettier キーがある場合も対象
$HAS_PRETTIER_CFG || jq -e '.prettier' "$PROJECT_ROOT/package.json" > /dev/null 2>&1 && HAS_PRETTIER_CFG=true

if $HAS_PRETTIER_CFG; then
  PRETTIER="$PROJECT_ROOT/node_modules/.bin/prettier"
  [ ! -f "$PRETTIER" ] && command -v prettier > /dev/null 2>&1 && PRETTIER="prettier"
  if [ -f "$PRETTIER" ] || command -v prettier > /dev/null 2>&1; then
    ${PRETTIER:-prettier} --write --ignore-unknown "$FILE" 2>/dev/null
    exit 0
  fi
fi

# --- eslint --fix (JS/TS 系のみ) ---
if echo "$FILE" | grep -qE '\.(js|jsx|ts|tsx|mjs|cjs)$'; then
  ESLINT="$PROJECT_ROOT/node_modules/.bin/eslint"
  if [ -f "$ESLINT" ]; then
    "$ESLINT" --fix "$FILE" 2>/dev/null
  fi
fi

exit 0
