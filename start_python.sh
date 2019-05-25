#!/bin/sh

# rsyslogd.pid
if [[ -f /var/run/rsyslogd.pid ]]
then
  rm /var/run/rsyslogd.pid
fi

# rsyslog
rsyslogd

# cron
chmod 0644 /etc/cron.d/python_cron
chown root:root /etc/cron.d/python_cron
chmod +x /app/kaminari_python/sh/python.sh
cron -f && touch /etc/cron.d/python_cron
