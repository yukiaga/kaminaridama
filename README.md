# kaminaridama
sxsw2019

# デプロイ
1. scp -i 秘密鍵指定 -r ローカルのディレクトリ指定(絶対パス) ユーザー名@接続先サーバー:サーバー内ディレクトリ指定(絶対パス) => EC2インスタンス内ファイルcopy
2. docker-compose -f docker-compose.yml up (docker-compose -f docker-compose-stg.yml up)

# 注意点
1. nginxエンドポイントで制限をかけている
2. healthcheckの設定はnginx.confのファイルを確認してからlocationの設定を工夫する必要があり

# nasa isslis_dataset（how to use）
- https://ghrc.nsstc.nasa.gov/pub/lis/iss/doc/isslis_dataset.pdf

# NRT science data（気象データ）
- https://ghrc.nsstc.nasa.gov/pub/lis/iss/data/science/nrt/
- https://ghrc.nsstc.nasa.gov/hydro/?platform[0]=ISS&instrument[0]=LIS#/?_k=q32b9v

# cronで見に行ってるデータ
- https://ghrc.nsstc.nasa.gov/pub/lis/iss/data/science/nrt/nc/

# その他
- https://github.com/yukiaga/kaminaridama/blob/master/kaminari_python/task/kaminari_task.py でnasaの気象データファイル => csvを実行している
- そのほかはcronの実行スクリプト、API、db保存スクリプト

