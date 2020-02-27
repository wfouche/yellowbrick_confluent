#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

${DIR}/setup-topics.sh
sleep .5
${DIR}/connectors/submit-connector.sh ${DIR}/connectors/orders-datagen.json

# Wait for datagen to write records
MAX_WAIT=120
CUR_WAIT=0
echo "\nWaiting up to $MAX_WAIT seconds for records to be written"
while [[ ! $(docker-compose logs kafka-connect) =~ "Stopping connector: generated the configured" ]]; do
  sleep 3
  CUR_WAIT=$(( CUR_WAIT+3 ))
  if [[ "$CUR_WAIT" -gt "$MAX_WAIT" ]]; then
    echo -e "\nERROR: waited ${MAX_WAIT} seconds but data gen hasn't finished\n"
    exit 1
  fi
done
  echo "records have been written to Kafka, please start JDBC sink"
