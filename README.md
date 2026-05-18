# Fitness App - 筋トレ記録を日付ごとに管理できるフィットネス記録アプリ

## サービス概要

筋トレの記録を日付ごとに管理し、過去のトレーニング内容を振り返ることができるWebアプリです。

ログイン後、マイページのカレンダーから日付を選択し、その日のトレーニング記録を登録できます。

種目、重量、回数、セット数、メモを記録できるため、紙のトレーニングノートのように使いながら、過去の記録を見返しやすくしています。

## サービス画像

※現在準備中です。  
トップページ、マイページのカレンダー、種目一覧、トレーニング記録登録画面のスクリーンショットを掲載予定です。

## サービスURL

※デプロイ後に記載予定です。

## アプリの使い方

1. ユーザー登録またはゲストログインを行います。
2. ログイン後、マイページに表示されるカレンダーから記録したい日付を選択します。
3. トレーニング記録登録画面で、種目、重量、回数、セット数、メモを入力します。
4. 登録した記録は、トレーニング記録一覧や詳細画面から確認できます。
5. 種目一覧画面では、トレーニング種目の登録、編集、削除、検索ができます。

## 開発背景

筋トレを継続するうえで、過去に扱った重量や回数を確認することは重要です。

しかし、紙のトレーニングノートでは過去の記録を探すのに時間がかかり、スマートフォンのメモアプリでは日付ごとの管理がしづらいと感じました。

そこで、カレンダーから日付を選択して記録を登録・確認できるWebアプリを作成しました。

日々のトレーニング内容を簡単に記録し、過去の成長を振り返りやすくすることを目的としています。

## 機能

### ユーザー機能

- ユーザー登録
- ログイン
- ログアウト
- ゲストログイン

### マイページ機能

- マイページ表示
- カレンダー表示
- 前月・翌月のカレンダー移動
- カレンダーの日付からトレーニング記録登録画面へ遷移

### 種目管理機能

- 種目一覧表示
- 種目登録
- 種目編集
- 種目削除
- 種目名検索
- 削除済み種目の再登録
- 有効な同名種目の重複防止

### トレーニング記録機能

- トレーニング記録一覧表示
- トレーニング記録詳細表示
- トレーニング記録登録
- トレーニング記録編集
- トレーニング記録削除
- 1つのトレーニング記録に複数セット登録
- セット追加
- セット削除
- 同じ日付の記録重複防止

## 工夫したところ

### カレンダーを起点にした記録導線

筋トレ記録は「いつ行ったか」が重要なため、ログイン後のマイページにカレンダーを表示し、日付を選択して記録できるようにしました。

一覧画面から記録を探すのではなく、日付を起点に登録・確認できるため、紙のトレーニングノートに近い感覚で使えるようにしています。

### 複数セットを登録できるDB設計

筋トレでは、1つの種目に対して複数セットを行うことが多いため、training_recordsとtraining_setsを分けて設計しました。

これにより、1日のトレーニング記録に対して、複数のセット情報を登録できるようにしています。

### 種目の論理削除

種目を完全に削除すると、過去のトレーニング記録に影響が出る可能性があります。

そのため、exercisesテーブルにactiveカラムを持たせ、削除済みの種目は一覧に表示しない形にしました。

また、削除済みの同名種目は再登録できるようにしつつ、有効な同名種目の重複は防ぐようにしています。

## 主な使用技術

### バックエンド

- Ruby 3.2.3
- Ruby on Rails 7.2.3

### フロントエンド

- HTML
- CSS
- Tailwind CSS

### データベース

- PostgreSQL

### 認証

- Devise

### 開発環境

- WSL2
- Ubuntu
- VSCode
- Git / GitHub

## ER図

```mermaid
erDiagram
    users ||--o{ exercises : "has_many"
    users ||--o{ training_records : "has_many"
    training_records ||--o{ training_sets : "has_many"
    exercises ||--o{ training_sets : "has_many"

    users {
        bigint id PK
        string email
        string encrypted_password
        datetime created_at
        datetime updated_at
    }

    exercises {
        bigint id PK
        bigint user_id FK
        string name
        string body_part
        text memo
        boolean active
        datetime created_at
        datetime updated_at
    }

    training_records {
        bigint id PK
        bigint user_id FK
        date trained_on
        text memo
        datetime created_at
        datetime updated_at
    }

    training_sets {
        bigint id PK
        bigint training_record_id FK
        bigint exercise_id FK
        integer weight
        integer reps
        integer set_number
        text memo
        datetime created_at
        datetime updated_at
    }