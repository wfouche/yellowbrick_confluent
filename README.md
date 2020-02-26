# Yellowbrick Test

This setup tests how quickly JDBC sink can read from Kafka topic and dump into Yellowbrick

## Steps
_NOTE: This project uses an API key for [iexcloud.io](https://iexcloud.io/) that has an allowance of 5 million requests per month, please don't leave the marketdata connector running all the time as it will eat up this request allowance_

1. Start the docker containers (starts zookeper, kafka brokers, schema registry, kafka-connect, C3, KSQLDB, posgres)
```
docker-compose up -d
```
2. Now we need to create the initial topics & start datagen connector
```
scripts/start.sh
```
_NOTE: This script uses scripts/setup-topics.sh &  scripts/connectors/submit-connector.sh scripts/connectors/orders-datagen.json_

3. Start the JDBC sink for postgres
```
scripts/connectors/submit-connector.sh scripts/connectors/postgres-sink.json
```
_NOTE: the Yellowbrick connection.url=jdbc:postgresql://ecosystem1.yellowbrick.io:5432/rc_kafka?loglevel=0&loginTimeout=30&socketTimeout=30&ApplicationName=YB ._
