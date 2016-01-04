#!/usr/bin/env bash

docker-compose run elasticdump --input=http://elk:9200/.kibana --output=/saved-visualizations/visualizations.json --type=data --searchBody='{"filter": { "or": [ {"type": {"value":"dashboard"}}, {"type" : {"value":"visualization"}}] }}'