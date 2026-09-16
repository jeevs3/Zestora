#!/bin/sh
set -e

PORT="${PORT:-8080}"

sed -i "0,/port=\"8080\"/s//port=\"$PORT\"/" "$CATALINA_HOME/conf/server.xml"

exec "$CATALINA_HOME/bin/catalina.sh" run