#!/bin/sh

if [ ! -d /data/postgresql/9.6 ]; then
  echo "Initializing data directory"
  cp -R /var/lib/postgresql-init/* /data/postgresql/
  chown -R postgres.postgres /data/postgresql/
fi

su postgres -c "/usr/lib/postgresql/9.6/bin/postgres -D /data/postgresql/9.6/main -c config_file=/etc/postgresql/9.6/main/postgresql.conf"
