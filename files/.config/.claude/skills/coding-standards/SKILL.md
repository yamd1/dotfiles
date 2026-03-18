---
name: coding-standards
description: >-
  コーディング規約とベストプラクティスのガイド。新機能実装・リファクタリング・コードレビュー時に参照する。
  最小限から始める原則、テスト戦略、依存性注入、命名規則、一般的なベストプラクティスを含む。
license: MIT
---

# コーディング規約

あなたはこの規約に従ってコードを書く。迷ったら「シンプルに、正直に、テスト可能に」に立ち返れ。

---

## 原則 1: 最小限から始める

**動作する最小限のコードを最初に書け。** 一度に全部作ろうとするな。

- まず動くものを作る → ユーザー確認 → 必要なら段階的に拡張する
- YAGNI (You Aren't Gonna Need It) — 今必要じゃない機能は作らない
- 早すぎる抽象化をしない。同じコードが3回出てきてから初めてDRYを考える
- 「将来のために」という理由でコードを複雑にしない

```ts
// BAD: 最初から汎用ユーティリティを作ろうとする
function fetchWithRetryAndCacheAndLogging<T>(url: string, options: FetchOptions<T>) { ... }

// GOOD: まず動くものを作る
async function fetchUser(id: string) {
  const res = await fetch(`/api/users/${id}`)
  return res.json()
}
```

---

## 原則 2: テストはコードとセット

**コード変更には必ずテストを伴わせる。** テストなし = 完成していない。

- 新機能: コードと同じPRにテストを含める
- バグ修正: バグを再現するテストを先に書いてから直す
- リファクタリング: 既存テストが通ることを確認してから変更する

### テストの粒度

```
単体テスト  → 関数・クラス単体の振る舞い
統合テスト  → モジュール間の連携
E2Eテスト   → ユーザー操作の主要フロー
```

### 良いテストの条件

- **Arrange / Act / Assert** の3段構成で書く
- テスト名は「何をテストするか」を日本語か英語で明確に書く
- 1テスト1アサーション（複数のことを一度に確かめようとしない）
- テストのために本番コードの構造を変えるのは OK — テスタビリティは設計品質の指標

```ts
// BAD: 何をテストしているか不明
it('works', () => { ... })

// GOOD: 何をテストするか明確
it('メールアドレスが未入力の場合にバリデーションエラーを返す', () => {
  // Arrange
  const form = new UserForm({ email: '' })
  // Act
  const result = form.validate()
  // Assert
  expect(result.errors.email).toBe('メールアドレスは必須です')
})
```

---

## 原則 3: 依存関係は外部注入

**関数・クラスは依存を自分で作らない。外から受け取る。**

- ハードコードされた依存（`new Database()`、`fetch` の直接呼び出し）はテストを壊す
- 依存性注入(DI)でテスト時にモックを差し込めるようにする
- 1関数・1クラスに1つの責務（Single Responsibility Principle）

```ts
// BAD: 依存を内部で生成している
class UserService {
  async getUser(id: string) {
    const db = new Database() // テストできない
    return db.find('users', id)
  }
}

// GOOD: 依存を外から注入
class UserService {
  constructor(private readonly db: Database) {}

  async getUser(id: string) {
    return this.db.find('users', id)
  }
}
```

### 責務の分け方

```
データ取得     → Repository / API Client
ビジネスロジック → Service / UseCase
UI表示         → Component / View
状態管理       → Store / Context
```

---

## 原則 4: 命名は可読性優先

**コードは書く時間より読む時間の方が長い。** 読む人のために命名する。

### 基本ルール

- 変数・関数名は**何をするか・何であるか**を表す
- 略語は避ける（`usr` → `user`、`calc` → `calculate`）
- ブール値は `is`/`has`/`can`/`should` で始める
- 関数名は動詞から始める（`getUser`、`validateEmail`、`handleClick`）
- 定数はSCREAMING_SNAKE_CASE (`MAX_RETRY_COUNT`)

```ts
// BAD
const d = new Date()
const u = users.filter(x => x.a)
function proc(data: any) { ... }

// GOOD
const createdAt = new Date()
const activeUsers = users.filter(user => user.isActive)
function processPayment(paymentData: PaymentData) { ... }
```

### コメントのルール

**コメントは「なぜ」を書く。「何を」はコードが語れ。**

- 複雑なロジック・非自明な判断・既知の制約にだけコメントをつける
- コードを読めばわかることは書かない
- TODO/FIXME には理由と対応予定を添える

```ts
// BAD: コードの繰り返し
// ユーザーを取得する
const user = await getUser(id)

// GOOD: なぜそうするかを説明
// Stripeは通貨をセント単位で扱うため100倍する
const amountInCents = price * 100

// TODO(2026-04): APIレート制限対応後にキャッシュを外す (#123)
```

---

## 原則 5: エラー処理

**エラーは握りつぶさない。適切な層でハンドルする。**

- try/catch は最小スコープに留める
- エラーメッセージはユーザーが行動できる内容にする
- 予期しないエラーはログに残す
- `null` より `undefined` より、明示的なエラー型を返す

```ts
// BAD: エラーを隠す
try {
  await sendEmail(user.email)
} catch (e) {} // 何が起きたかわからない

// GOOD: 適切に処理
try {
  await sendEmail(user.email)
} catch (error) {
  logger.error('メール送信失敗', { userId: user.id, error })
  throw new EmailDeliveryError(`${user.email} への送信に失敗しました`)
}
```

---

## 原則 6: 関数・コンポーネントの設計

- **関数は20行以内**を目安に。超えたら分割を検討する
- 引数は3つまで。それ以上ならオブジェクトにまとめる
- 副作用（DB書き込み、API呼び出し、状態変更）は関数の外に追い出すか、明示的に分離する
- Pure functionを優先する（同じ入力 → 同じ出力、副作用なし）

```ts
// BAD: 引数が多すぎる
function createUser(name: string, email: string, age: number, role: string, plan: string) { ... }

// GOOD: オブジェクトにまとめる
function createUser(params: {
  name: string
  email: string
  age: number
  role: UserRole
  plan: PlanType
}) { ... }
```

---

## 原則 7: 型安全性

TypeScriptを使うプロジェクトでは：

- `any` は使わない。使う場合はコメントで理由を書く
- `unknown` を使って型ガードで絞り込む
- 型アサーション (`as`) は最終手段
- 共用体型・ブランド型を活用して不正な状態を型で弾く

```ts
// BAD
function parse(data: any) { return data.value }

// GOOD
function parse(data: unknown): string {
  if (typeof data === 'object' && data !== null && 'value' in data) {
    return String((data as { value: unknown }).value)
  }
  throw new ParseError('予期しないデータ形式')
}
```

---

## チェックリスト（PR前に確認）

- [ ] 最小限のコードで実装できているか
- [ ] テストを追加・更新したか
- [ ] 依存関係はDIになっているか
- [ ] 命名はわかりやすいか（略語・謎の変数名がないか）
- [ ] 不要なコメントを書いていないか
- [ ] `any` を使っていないか
- [ ] エラーを握りつぶしていないか
- [ ] 関数が1つの責務に収まっているか
