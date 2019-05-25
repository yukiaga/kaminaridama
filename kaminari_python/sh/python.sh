#!/bin/sh

# 19時28分30秒とかに1926のncファイル上がるから３０秒待てばいい
sleep 30s

# Sat Feb 23 08:30:31 UTC 2019: executed Lightning.download_nc_file_from_NASA
# ISS_LIS_SC_P0.2_20190223_082805_NRT_12175.ncのdownloadに成功しました
# Sat Feb 23 08:30:44 UTC 2019: finished Lightning.download_nc_file_from_NASA

# のような感じになるから20秒待つ
sleep 20s

echo "$(date): executed script" >> /var/log/cron.log 2>&1

/usr/local/bin/python /app/kaminari_python/task/kaminari_task.py >> /var/log/cron.log 2>&1

echo "$(date): finished script" >> /var/log/cron.log 2>&1

echo "------------------------------------------------------------------------------------" >> /var/log/cron.log 2>&1
