#!/bin/bash
# 現在のディレクトリのパスを取得
currentPath=$(pwd)
     
#サブプロジェクトのパスを生成
prj1Path="$currentPath/subproject1"
prj2Path="$currentPath/subproject2"
   
# .envファイルに書き出す
cat <<EOF > .devcontainer/.env
CURRENT_PATH=$currentPath
PRJ1_PATH=$prj1Path
PRJ2_PATH=$prj2Path
EOF

echo ".env file has been created successfully in .devcontainer/"