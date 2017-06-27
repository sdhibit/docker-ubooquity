#! /bin/sh
. /etc/envvars
set -e
exec 2>&1

cd /config
# Start Ubooquity
/sbin/su-exec ubooquity /usr/bin/java -jar /opt/ubooquity/Ubooquity.jar \
  --workdir "/config" \
  --headless \
  --webadmin \
  --port 2202
  --host 0.0.0.0
