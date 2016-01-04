#!/usr/bin/env bash

docker-compose run elasticdump --input=/saved-visualizations/visualizations.json --output=http://elk:9200/.kibana