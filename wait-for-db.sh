#!/bin/bash
  service="chalmers database"
  host=$DATABASE_HOST
  port=3306

  echo "waiting for $service to be up on $host:$port..."

  if [ -n "$host" -a -n "$port" ]; then
    # nc command is the key for the TCP probe
    while ! nc -w 1 -c echo $host $port
    do
      echo -n .
      sleep 1
    done

    echo 'ok'
  else
    echo "[ERROR] invalid host=$host or port=$port for $service"
    exit 1
  fi