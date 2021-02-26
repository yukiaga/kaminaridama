# kaminaridama
sxsw2019

# デプロイ
1. scp -i 秘密鍵指定 -r ローカルのディレクトリ指定(絶対パス) ユーザー名@接続先サーバー:サーバー内ディレクトリ指定(絶対パス) => EC2インスタンス内ファイルcopy
2. docker-compose -f docker-compose.yml up (docker-compose -f docker-compose-stg.yml up)

# 注意点
1. nginxエンドポイントで制限をかけている
2. healthcheckの設定はnginx.confのファイルを確認してからlocationの設定を工夫する必要があり


