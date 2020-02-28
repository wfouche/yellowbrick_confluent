#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RECORD_COUNT=3000000

echo "Dropping table if exists..."
docker exec postgres psql -c 'DROP TABLE IF EXISTS orders;'

echo "Creating table..."
docker exec postgres psql -c 'CREATE TABLE orders  (ORDERID int PRIMARY KEY, SIDE varchar(10), QUANTITY int, SYMBOL varchar(20), ACCOUNT varchar(20), USERID varchar(20));'

echo "Submitting postgres sink..."
${DIR}/connectors/submit-connector.sh ${DIR}/connectors/postgres-sink.json
START=$(date +%s)
sleep 2
echo
echo "Waiting for data to be written to Postgres"
while true;
do
  COUNT=$(docker exec postgres psql -t -A -c 'select count(*) from orders;' 2> /dev/null)
  if [[ ${COUNT} -eq ${RECORD_COUNT} ]]; then
    END=$(date +%s)
    break
  fi
  echo -ne "${COUNT} records written\033[0K\r"
  sleep .5
done

echo "${RECORD_COUNT} records written to Postgres in $(( ${END} - ${START} )) seconds"
echo "  $(( ${RECORD_COUNT}/$(( ${END} - ${START})))) records per second"

