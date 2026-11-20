#!/bin/sh

set -e

PORT="${PORT:-8080}"

sed -i "0,/port=\"8080\"/s//port=\"$PORT\"/" "$CATALINA_HOME/conf/server.xml"

# Keep Tomcat inside a 512 MB free instance
export CATALINA_OPTS="-Xms64m -Xmx300m -XX:+UseSerialGC"

exec "$CATALINA_HOME/bin/catalina.sh" run
