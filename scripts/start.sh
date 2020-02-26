#!/bin/bash
sh ./setup-topics.sh
sleep .5
sh ./connectors/submit-connector.sh connectors/orders-datagen.json
