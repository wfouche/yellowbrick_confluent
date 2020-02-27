#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RECORD_COUNT=3000000

echo "Submitting postgres sink..."
${DIR}/connectors/submit-connector.sh ${DIR}/connectors/postgres-sink.json
START=$(date +%s)
sleep 2
echo
echo "Waiting for data to be written to Postgres"
while true;
do
  COUNT=$(docker exec postgres psql -U admin -d orders -t -A -c 'select count(*) from orders;' 2> /dev/null)
  if [[ ${COUNT} -eq ${RECORD_COUNT} ]]; then
    END=$(date +%s)
    break
  fi
  echo -ne "${COUNT} records written\033[0K\r"
  sleep .5
done

echo "${RECORD_COUNT} records written to Postgres in $(( ${END} - ${START} )) seconds"
echo "  $(( ${RECORD_COUNT}/$(( ${END} - ${START})))) records per second"

