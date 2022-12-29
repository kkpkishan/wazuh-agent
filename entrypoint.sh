#!/bin/bash

worker="${JOIN_WORKER}"
manager="${JOIN_MANAGER}"
 name="${HOSTNAME}"
sed -i "s/MANAGER_IP/$worker/g" /var/ossec/etc/ossec.conf
sed -i "s/udp/tcp/g" /var/ossec/etc/ossec.conf

# Start the agent
/var/ossec/bin/wazuh-control start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start agent: $status"
  exit $status
fi

echo "background jobs running, listening for changes"

while true 
do
  /var/ossec/bin/wazuh-control status
  status=$?
  if [ $status -ne 0 ]; then
    echo "looks like the agent died...Exiting the container."
    exit 1
  fi
  sleep 120
done