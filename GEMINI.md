# プロジェクト開始時の必読情報

## 重要: 最初に読み込むファイル
- `/workspace/main/instructions.md` - プロジェクトの基本構成とワークフロー
- `/workspace/main/memory.md` - 前回の作業内容と現在の状態

## 起動時の手順
1. まず `main/instructions.md` を読み込んでプロジェクト構成を理解
2. `main/memory.md` を確認して前回の作業内容を把握
   - もし `main/memory.md` が存在しない場合は、`main/memory.md.example` をコピーして `main/memory.md` を作成してから読み込む
3. 必要に応じて適切なサブプロジェクトのVSCodeウィンドウを開く

## 重要: 環境再開時の記録ルール
新しく環境を開く場合（初回起動、リビルド後の再開、新規セッション開始など）は、**必ず最初に`main/memory.md`に現在の状況を記録**してください。特にリビルドが必要な場合は、リビルド前に以下を記録：
- 現在の作業内容と進捗状況
- リビルドが必要な理由
- リビルド後に継続すべき作業
- 次のステップや注意事項

## サブプロジェクトのシェル起動コマンド
`main`コンテナのCLIから、以下のコマンドで各サブプロジェクトのコンテナ内シェルを起動できます。

- **subproject1:**
  ```bash
  docker compose -f subproject1/docker-compose.yml run --rm app bash
  ```
- **subproject2:**
  ```bash
  docker compose -f subproject2/docker-compose.yml run --rm app bash
  ```

これにより、ホストのファイルをマウントした状態で、コンテナ内で直接コマンドを実行できます。

