#!/bin/sh

# rsyslogd.pid
if [[ -f /var/run/rsyslogd.pid ]]
then
  rm /var/run/rsyslogd.pid
fi

# rsyslog
rsyslogd

# cron
chmod 0644 /etc/cron.d/api_cron
chown root:root /etc/cron.d/api_cron
chmod +x /app/kaminari_API/kaminari_API_rails/lib/tasks/dl_and_save_lightning.sh
cron && touch /etc/cron.d/api_cron

# BUNDLER_PATH=./vendor/bundle

#pid
if [[ -f ./tmp/pids/server.pid ]]
then
  rm ./tmp/pids/server.pid
fi

# bundle install --path=vendor/bundle cron
bundle install
bundle exec rails s -b 0.0.0.0


