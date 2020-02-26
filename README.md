# Yellowbrick Test

This project initalizes Kafka, writes 3million messages into a Kafka topic via the datagen connector and then sinks those messages into a postgres JDBC source

## Steps

1. Start the docker container (starts zookeper, kafka brokers, schema registry, kafka-connect, C3, KSQLDB, postgres)
```
docker-compose up -d
```
2. Create the initial topics & start the datagen connector
```
scripts/start.sh
```

3. Start the JDBC sink for postgres
```
scripts/connectors/submit-connector.sh scripts/connectors/postgres-sink.json
```

