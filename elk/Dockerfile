FROM qnib/elk

ADD ./10-stockfighter-filter.conf /etc/default/logstash/10-stockfighter-filter.conf

RUN /usr/share/elasticsearch/bin/plugin --install jettro/elasticsearch-gui