# Yellowbrick Test

This project initalizes Kafka, writes 3million messages into a Kafka topic via the datagen connector and then sinks those messages into a postgres JDBC sink

## Steps

create an `.env` file with the following variables for connecting to the postgres database:
```
PGHOST=
PGPORT=
PGDATABASE=
PGUSER=
PGPASSWORD=
```

1. Start the docker container (starts zookeper, kafka brokers, schema registry, kafka-connect, C3, KSQLDB, postgres)
```
docker-compose up -d
```
2. Create the initial topics & start the datagen connector
```
scripts/create-kafka-records.sh
```

3. Start the JDBC sink for postgres, it will track the records and report records per second
```
scripts/sink-and-measure.sh
```

