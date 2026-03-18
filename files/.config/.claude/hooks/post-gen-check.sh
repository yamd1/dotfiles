#!/bin/bash
# Claude Code Stop hook: TypeScript型チェック + テスト実行（汎用）
# package.json に scripts が存在する場合のみ実行
# エラー時のみ additionalContext で Claude に通知（トークン節約）

PROJECT_DIR="$(pwd)"

# package.json がなければスキップ（非 Node プロジェクト）
[ ! -f "$PROJECT_DIR/package.json" ] && exit 0

FAIL=""

# typecheck スクリプトがあれば実行、なければ tsconfig.json + tsc --noEmit にフォールバック
if jq -e '.scripts.typecheck' "$PROJECT_DIR/package.json" > /dev/null 2>&1; then
  TSC_OUT=$(npm run typecheck 2>&1)
  if [ $? -ne 0 ]; then
    FAIL="[TypeScript errors]\n${TSC_OUT}"
  fi
elif [ -f "$PROJECT_DIR/tsconfig.json" ]; then
  TSC_OUT=$(npx tsc --noEmit 2>&1)
  if [ $? -ne 0 ]; then
    FAIL="[TypeScript errors]\n${TSC_OUT}"
  fi
fi

# test スクリプトがあれば実行（出力は末尾80行に制限）
if jq -e '.scripts.test' "$PROJECT_DIR/package.json" > /dev/null 2>&1; then
  TEST_OUT=$(npm test 2>&1)
  if [ $? -ne 0 ]; then
    TEST_SHORT=$(echo "$TEST_OUT" | tail -80)
    FAIL="${FAIL}\n[Test failures]\n${TEST_SHORT}"
  fi
fi

# エラーがある場合のみ Claude に通知して自動修正を促す
if [ -n "$FAIL" ]; then
  CONTEXT=$(printf '%b' "$FAIL" | jq -Rs .)
  printf '{"hookSpecificOutput":{"hookEventName":"Stop","additionalContext":%s}}' "$CONTEXT"
fi
