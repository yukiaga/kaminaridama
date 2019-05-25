# kaminaridama
sxsw2019

# デプロイ方法
1. scp -i 秘密鍵指定 -r ローカルのディレクトリ指定(絶対パス) ユーザー名@接続先サーバー:サーバー内ディレクトリ指定(絶対パス)
でコピーする
2. そのあと、docker-compose -f docker-compose-stg.yml up を行う

# 注意点
1. nginxでエンドポイントで制限をかけている
2. なのでhealthcheckの設定はnginx.confのファイルを確認してからlocationの設定を工夫する必要がある。


