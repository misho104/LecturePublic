# CoreMathematics — AI Agent 使い方メモ

## ビルド

```sh
make          # lecture.pdf をコンパイル
make watch    # 保存のたびに自動コンパイル
make o        # PDF を開く
```

---

## AI スキル一覧

| スキル名 | 使いどころ |
|---------|----------|
| `typst-description` | 本文の説明文を書き直す・補足する |
| `typst-examples` | `#example[]` + `#solution[]` ペアを追加する |
| `typst-exercises` | `#problems[]` / `#quizzes[]` に問題を追加する |
| `typst-math` | `#theorem[]` や数式ブロックを追加・修正する |
| `typst-ai-process` | ファイル内の `// !AI` マーカーを一括処理する ← これが便利 |

### スキルの呼び出し方（この CLI 上で）

```
> typst-examples スキルを使って 1-derivative.typ に chain rule の例題を追加して
> typst-exercises スキルを使って 2-units.typ に level-4 の問題を追加して
> typst-ai-process スキルを使って 1-derivative.typ を処理して
```

---

## !AI マーカー（一番便利な使い方）

`.typ` ファイルの好きな場所に `// !AI` コメントを書いておく。
後でまとめて処理すると、その位置に自動でコンテンツが生成される。

### マーカー構文

```typst
// !AI description: <何を説明してほしいか>
// !AI example:     <どんな例題を作ってほしいか>
// !AI exercise:    <どんな演習問題を作ってほしいか>
// !AI quiz:        <どんな確認クイズを作ってほしいか>
// !AI theorem:     <どんな定理を書いてほしいか>
```

### 書き方の例

```typst
= Chain Rule

// !AI description: f(g(x)) の連鎖律を説明。内側の微分を忘れる典型ミスに言及

#quizzes[
  + `4` Differentiate $sin(x^2)$.
]

// !AI example: 積の微分則の worked example。定数との混同ミスを示す解答付き

// !AI exercise: 連鎖律の level-4 と level-3 問題。内側微分を忘れるケースに特化
```

### 一括処理の呼び出し方

```
> typst-ai-process スキルを使って 1-derivative.typ の !AI マーカーを全部処理して
```

複数ファイルまとめても OK：

```
> typst-ai-process スキルを使って全 .typ ファイルの !AI マーカーを処理して
```

---

## カスタム環境クイックリファレンス

| 環境 | 用途 |
|------|------|
| `#remark[...]` | 一般的な注記 |
| `#be-careful[...]` | 典型ミスへの警告（赤） |
| `#fail-safe[...]` | 詰まったときのヒント（小文字グレー） |
| `#advanced-note[...]` | 発展的内容（小文字パープル） |
| `#theorem(title: none)[...]` | 定理（青枠） |
| `#example(title: none)[...]` | 例題（緑枠） |
| `#solution[...]` | `#example` の直後に置く解答 |
| `#quizzes[...]` | 本文中の確認クイズ |
| `#problems[...]` | セクション末の演習問題セット |
| `#keyword[word]` | 強調 + 索引登録 |
| `#h-enum(cols: N)[+ ...]` | N列の番号付きリスト |
| `#no-num($...$)` | 番号なし数式 |

### 問題レベル
- `` `4` `` 必須　`` `3` `` 標準　`` `2` `` 発展　`` `1` `` 挑戦　`` `9` `` ドリル

### 数式ヘルパー（physica.typ）

| 記法 | 意味 |
|------|------|
| `dv(f, x)` | $df/dx$ |
| `dv(f, x, x)` | $d^2f/dx^2$ |
| `dv(x)f` | $(d/dx)f$（演算子形式） |
| `pdv(f, x)` | $\partial f/\partial x$ |
| `eval(expr)` | $\left.\text{expr}\right\|$（代入バー） |
