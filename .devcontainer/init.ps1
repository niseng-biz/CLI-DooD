# 現在のディレクトリのパスを取得
$currentPath = (Get-Location).Path

# Join-Pathを使って、OSに合った正しい形式のパスを組み立てる
$prj1Path = Join-Path -Path $currentPath -ChildPath 'subproject1'
$prj2Path = Join-Path -Path $currentPath -ChildPath 'subproject2'

# ヒアストリング (@" ... "@) を使って、複数行のテキストをきれいに作成
$envContent = @"
CURRENT_PATH=$currentPath
PRJ1_PATH=$prj1Path
PRJ2_PATH=$prj2Path
"@

# .envファイルに書き出す
$envContent | Out-File -FilePath ".devcontainer/.env" -Encoding utf8 -Force

Write-Host ".env file has been created successfully in .devcontainer/"