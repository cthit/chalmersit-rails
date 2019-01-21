#!/bin/bash
# Wait for the database to start up

host="$1"
password="$2"

until mysql -h "$host" --user="root" --password="$password" --execute="\q"; do
    >&2 echo "MySQL is unavailable - sleeping"
    sleep 2
done

>&2 echo "MySQL is up - executing order 66"

bundle exec rake db:create db:migrate
bundle exec rake rails:update:bin
rm tmp/pids/server.pid
rails s -p 3000 -b '0.0.0.0'