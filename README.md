# CLI DooD (Docker outside of Docker)

## 1. 概要

このリポジトリは、Claude CodeやGemini CLIといった強力な開発AIエージェントを中心となる `main` 開発コンテナに配し、
開発AIエージェントを用いて、各サブプロジェクトを独立したDev Containerとして開発、実行、管理することができます。
ユーザーはこのdevconteinerを起動後、geminiもしくはclaudeを呼び出して、開発を行うことができます。
各AIエージェントの作業レベリングのために `main` 内にmemory.mdという記憶管理ファイルを保持しています。
初期に読み込む設定にしていますが、頻繁に読み込み忘れるため、main/memory.mdを読んでというお願いを最初にしたほうがいいかもしれません。
memory.mdに書き込むタイミングもバラバラなので「これまでの作業の要約と次に行うことをmemory.mdに書き込んで」とお願いするのも有効です。

## 2. 前提条件

### 必要なソフトウェア
- **Docker Desktop**: コンテナ環境を実行するために必要
- **Visual Studio Code**: 開発環境として使用
- **Dev Containers拡張機能**: VS CodeでDev Containerを使用するために必要

### 必要なAIエージェント（どちらか一方または両方）
- **Claude Code**: Anthropic社のClaude AIを使用した開発ツール
- **Gemini CLI**: Google社のGemini AIを使用した開発ツール

### APIキー
- **Anthropic API Key**: Claude Codeを使用する場合
- **Google AI API Key**: Gemini CLIを使用する場合

## 3. セットアップ手順

### ステップ1: リポジトリのクローン
```bash
git clone https://github.com/niseng-biz/CLI-DooD.git
cd cli-dev-container-project
```

### ステップ2: 環境変数の設定
1. `.env.example`ファイルを参考に`.env`ファイルを作成
2. 必要なAPIキーを設定
```bash
# .env ファイルの例
PROJECT_ROOT=/workspace

# Claude Code用
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"

# Gemini CLI用
export GEMINI_API_KEY="your-gemini-api-key-here"
```

3. 絶対パスの指定方法の設定
ルートフォルダ直下の.devcontainerフォルダ内のdevcontainer.jsonに絶対パスを取得するための"initializeCommand"があります。
これをお使いのOSに合わせて変更してください。


### ステップ3: Dev Containerの起動
1. VS Codeでプロジェクトルートを開く
2. コマンドパレット（Ctrl+Shift+P / Cmd+Shift+P）を開く
3. 「Dev Containers: Reopen in Container」を選択
4. `main`コンテナが起動するまで待機

### ステップ4: AIエージェントの起動
コンテナ内のターミナルでAIエージェントを起動：
```bash
# Claude Codeの場合
claude

# Gemini CLIの場合
gemini
```

## 4. ファイル構成と役割

```
/workspace/
├── README.md                    # このファイル
├── .devcontainer/               # メインコンテナの設定
│   └── ...
├── main/                        # 管理ハブコンテナ
│   ├── instructions.md          # AIエージェント用の指示書
│   └── memory.md                # AIエージェントの作業記録
├── subproject1/                 # Node.jsサブプロジェクト
│   └── ...
└── subproject2/                 # Pythonサブプロジェクト
    └── ...
```

-   `/main`: プロジェクト全体の管理ハブとなる開発コンテナです。AIエージェントやDockerツールが含まれます。
-   `/subproject*`: 各サブプロジェクトのディレクトリです。それぞれが独立したアプリケーションを含みます。
-   `main/instructions.md`: AIエージェントがプロジェクトの構造やルールを理解するための最も重要な指示書です。
-   `main/memory.md`: AIエージェントが作業履歴を記録し、コンテキストを維持するためのファイルです。

## 5. クイックスタート

セットアップ完了後、`main`コンテナのターミナルでAIエージェントを起動し、以下の���示を出すことで動作確認ができます。

### 基本的な使用例

1. **AIエージェントの起動**
   ```bash
   # Gemini CLIの場合
   gemini
   ```

2. **subproject1（Node.js）の実行**
   AIエージェントに以下のように指示：
   ```
   subproject1のapp.jsを実行してください
   ```
   
   期待される動作：
   - AIエージェントが `docker compose -f subproject1/docker-compose.yml run --rm app node app.js` を実行する
   - `Hello from subproject1` が出力される

3. **subproject2（Python）の実行**
   AIエージェントに以下のように指示：
   ```
   subproject2のhello.pyを実行してください
   ```
   
   期待される動作：
   - AIエージェントが `docker compose -f subproject2/docker-compose.yml run --rm app python hello.py` を実行する
   - `hello from subproject2` が出力される

### AIエージェントとの対話例

```
ユーザー: subproject1のapp.jsを実行してください

AIエージェント: 
承知いたしました。subproject1のコンテナ内でapp.jsを実行します。
(docker compose -f subproject1/docker-compose.yml run --rm app node app.js を実行)
→ Hello from subproject1
```

### 作業記録の確認

AIエージェントに以下のように指示して、前回の作業内容を確認：
```
main/memory.mdを読んで、前回の作業内容を教えてください
```

## 7. AI主導のインテリジェントな開発ワークフロー

このプロジェクトの開発は、**管理ハブである`main`コンテナを司令塔**として、AIエージェントが主体となって行います。ユーザーは「何をしたいか」という高レベルの目標を指示するだけで、AIエージェントが具体的な技術的タスクを自律的に分析・実行します。

### 開発シナリオ例: Reactランディングページの作成

ユーザーがAIエージェントに以下のように指示した場合の、AIの自律的な開発プロセスを示します。

#### ステップ1: ユーザーからの高レベルな目標指示

> **ユーザー:**
> 「`subproject1`について、Reactで簡単なランディングページを作成して。ページには「Welcome to Our Project」という見出しと、「This is an AI-generated landing page.」という段落を表示させてください。完成したら、ブラウザで確認できるようにして。」

#### ステップ2: AIエージェントによる自律的な開発サイクル

ユーザーの指示を受け、AIエージェントは`main`コンテナ内で以下のタスクを順次実行します。

1.  **現状分析と計画策定**
    -   `subproject1/package.json` を読み込み、Reactがまだ導入されていないことを確認します。
    -   静的ファイル（HTML, JS）を配信するためのWebサーバーが必要だと判断します。
    -   *(内部アクション: `read_file`, `search_file_content`)*

2.  **環境構築（依存関係の追加）**
    -   React (`react`, `react-dom`) と、シンプルなWebサーバー (`http-server`) を`npm`でインストールします。
    -   *(内部アクション: `run_shell_command` で `docker compose ... run --rm app npm install react react-dom http-server` を実行)*

3.  **ソースコードの生成とファイル構成**
    -   `subproject1/src` ディレクトリを作成します。
    -   `public/index.html` を作成し、Reactアプリのマウントポイントとなる `<div id="root"></div>` を記述します。
    -   `src/App.js` を作成し、指示された見出しと段落を持つReactコンポーネントを記述します。
    -   `src/index.js` を作成し、`App`コンポーネントを`index.html`の`root`要素にレンダリングする処理を記述します。
    -   *(内部アクション: `run_shell_command` で `mkdir`, `write_file` を複数回実行)*

4.  **設定の更新と構成**
    -   `subproject1/package.json` を変更し、`"start": "http-server public -p 8080"` という起動スクリプトを追加します。
    -   `subproject1/docker-compose.yml` を確認し、コンテナのポート `8080` をホストに公開するための `ports` 設定 (`- "8080:8080"`) がなければ追加します。
    -   *(内部アクション: `read_file`, `replace`)*

5.  **アプリケーションの起動と検証**
    -   新しく追加した `start` スクリプトを実行して、開発サーバーをバックグラウンドで起動します。
    -   *(内部アクション: `run_shell_command` で `docker compose ... up -d` または `docker compose ... run --rm app npm start &` を実行)*

#### ステップ3: 完了報告と次のステップ

-   AIエージェントは、一連のタスクが完了したことと、結果を確認する方法をユーザーに報告します。

> **AIエージェント:**
> 「Reactランディングページの作成が完了しました。開発サーバーをポート8080で起動しましたので、Webブラウザで `http://localhost:8080` を開いてご確認ください。」

このように、ユーザーは抽象的な指示を出すだけで、AIエージェントが具体的な実装からデプロイまでの一連の流れを自律的に処理します。
