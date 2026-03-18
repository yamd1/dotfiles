---
name: auto-format
description: >-
  プロジェクトのフォーマッター設定を確認・セットアップする。フォーマットが効いていない時、
  新しいプロジェクトでフォーマッターを導入したい時に使う。biome / prettier / eslint を
  自動検出してプロジェクトの設定ファイルと hooks を構成する。
license: MIT
---

# Auto Format セットアップ

あなたはこのスキルを使ってプロジェクトのフォーマッター設定を確認・構成する。

> グローバルフック (`~/.claude/hooks/format-file.sh`) が PostToolUse (Write|Edit) で
> 自動発火するため、通常は追加設定不要。
> このスキルは「フォーマットが効いていない」「プロジェクトにフォーマッターを導入したい」
> 場合に使う。

---

## 起動時にやること

1. `package.json` を読んでフォーマッター関連の設定を確認する
2. 設定ファイルの存在をチェックする（`.prettierrc*`, `biome.json`, `.eslintrc*` など）
3. 現状のフォーマッター状況をユーザーに報告する
4. 不足があれば設定を提案・追加する

---

## 検出優先順位

```
biome.json / biome.jsonc        →  biome format --write
.prettierrc* / prettier.config.* →  prettier --write --ignore-unknown
package.json に "prettier" キー  →  prettier --write --ignore-unknown
.eslintrc* (JS/TS のみ)          →  eslint --fix
```

---

## フォーマッターが未設定のプロジェクトへの対応

prettier を推奨する。以下をユーザーに提案する:

```bash
npm install -D prettier
```

最小限の `.prettierrc.json`:
```json
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100
}
```

`package.json` に format スクリプトを追加:
```json
{
  "scripts": {
    "format": "prettier --write ."
  }
}
```

---

## グローバルフックの仕組み

`~/.claude/hooks/format-file.sh` が `PostToolUse` (Write|Edit) で自動発火する。

動作フロー:
1. 書き込まれたファイルパスを stdin JSON から取得
2. 親ディレクトリを辿ってプロジェクトルートを特定
3. フォーマッター設定ファイルを検出
4. 対応するフォーマッターを実行（設定がなければ何もしない）

---

## トラブルシューティング

| 症状 | 確認事項 |
|------|---------|
| フォーマットが効かない | フォーマッター設定ファイルが存在するか確認 |
| エラーが出る | `~/.claude/hooks/format-file.sh` を直接実行してみる |
| 特定ファイルだけ動かない | 拡張子が対象か、ignore設定を確認 |

設定確認コマンド:
```bash
# フックが正しく設定されているか
jq '.hooks.PostToolUse' ~/.claude/settings.json

# スクリプトが実行可能か
ls -la ~/.claude/hooks/format-file.sh
```
