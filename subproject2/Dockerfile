# 子プロジェクト2 (例: Pythonプロジェクト)
FROM python:3.10-slim-bullseye

# ワーキングディレクトリの設定
WORKDIR /workspace/subproject2

# pythonコマンドでpython3が実行されるようにシンボリックリンクを作成
RUN ln -s /usr/bin/python3 /usr/bin/python

# 依存関係のインストール (必要に応じて)
# COPY subproject2/requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt

# 確認用メッセージ
RUN echo "Subproject2 (Python) container's Dockerfile."
