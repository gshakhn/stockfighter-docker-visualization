# About

This project brings up an ELK docker container with some [Stockfighter](stockfighter.io) configuration.

![Example Screenshot](/screenshots/example.png?raw=true)

# Usage

1. Run `docker-compose up elk` to bring up the ELK container.
2. Run your Stockfighter code and log various things to logstash. See below for logging.
3. Hit localhost:5601 to access Kibana.
4. Fill in the Time-field name with `@timestamp` and hit create.
5. Run `./load-visualizations.sh` to load the preconfigured visualizations/dashboards into Kibana.
6. Go to the Visualize tab and clear your session if you get an error.
   Apparently Kibana doesn't like you mucking with visualizations/dashboards while you have a session.
7. Go to Dashboard tab and load the Stockfighter dashboard.

# Limitations

The dashboard only supports a single stock. If you're logging multiple stocks, they'll show up as one line.

Kibana doesn't support graphing individual entries, only aggregations. Currently the visualizations graph
the average on a second granularity, so you won't get precise graphs if you have multiple updates a second.
Also, if your time window is > 8 minutes, Kibana will complain about too many buckets and scale the window to 5 seconds.

The above limitations are based on my limited understanding of Kibana. I decided to learn about ELK over a weekend to
visualize Stockfighter information. Take everything above with a grain of salt.

# Logging

## Logstash Filters

The log filter configuration is in [elk/10-stockfighter-filter.conf](https://github.com/gshakhn/stockfighter-docker-visualization/blob/master/elk/10-stockfighter-filter.conf).
The [kv](https://www.elastic.co/guide/en/logstash/current/plugins-filters-kv.html) filter automatically grabs field and values split on `=`. 

My code log the following messages in the following format to Logstash:
`AskDepth=22 AskSize=22 Ask=3633 BidDepth=1395 BidSize=465 Bid=3487 Last=3633 LastSize=12 OpenOrders=4 StockOwned=4 Basis=126642 NAV=14532 Profit=141174`

## Getting logs into Logstash

The [base elk repo](https://github.com/ChristianKniep/docker-elk/blob/master/etc/default/logstash/00_entry.conf) has the built in ones for this container.
I use UDP on port 55514 using [logstash-logback-encoder](https://github.com/logstash/logstash-logback-encoder).

You can also add your own. See the [Logstash docs](https://www.elastic.co/guide/en/logstash/current/input-plugins.html) for choices. There is also another [ELK docker](https://github.com/spujadas/elk-docker) repo that has examples on how to configure input.

Some ideas, in no particular order and no comment on usefulness:
* Automatically tweet your profit and use the Twitter input.
* Use the websocket input and connect to the quote endpoint.

There are other ways of sending logs.
