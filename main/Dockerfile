FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye

# Docker-in-Dockerのセットアップに必要なツールをインストール
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends apt-transport-https ca-certificates curl gnupg2

# DockerのGPGキーを追加
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Dockerリポジトリを追加
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker CLIとDocker Composeをインストール
RUN apt-get update && apt-get -y install \
    docker-ce-cli \
    docker-compose-plugin

# # nodeユーザーが存在することを確認し、存在しない場合は作成
# RUN id -u node &>/dev/null || useradd -m -s /bin/bash node

# # dockerグループを作成（存在しない場合）し、nodeユーザーを追加
# RUN if ! getent group docker > /dev/null 2>&1; then \
#         groupadd docker; \
#     fi && \
#     usermod -aG docker node

# 追加の依存関係をインストール
RUN apt-get install -y \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g npm@11.4.2 @google/gemini-cli \
    && npm install -g @anthropic-ai/claude-code

    
# # nodeユーザーにsudo権限を付与（必要に応じて）
# RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# RUN chmod 666 /var/run/docker.sock || true

# # 確認用メッセージ
# RUN echo "Main container's Dockerfile. Gemini CLI should be installed here."