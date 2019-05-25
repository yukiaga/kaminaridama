#!/bin/sh

# 19時28分30秒とかに1926のncファイル上がるから３０秒待てばいい
sleep 30s

cd /app/kaminari_API/kaminari_API_rails


echo "$(date): executed Lightning.download_nc_file_from_NASA" >> /var/log/cron.log 2>&1

/usr/local/bin/bundle exec /usr/local/bundle/bin/rails runner -e development Lightning.download_nc_file_from_NASA >> /var/log/cron.log 2>&1

echo "$(date): finished Lightning.download_nc_file_from_NASA" >> /var/log/cron.log 2>&1

echo "-------------------------------------------------------------------------------" >> /var/log/cron.log 2>&1


sleep 17s


echo "$(date): executed Lightning.read_csv_and_write_db" >> /var/log/cron.log 2>&1

/usr/local/bin/bundle exec /usr/local/bundle/bin/rails runner -e development Lightning.read_csv_and_write_db >> /var/log/cron.log 2>&1

echo "$(date): finished Lightning.read_csv_and_write_db" >> /var/log/cron.log 2>&1

echo "-------------------------------------------------------------------------------" >> /var/log/cron.log 2>&1
