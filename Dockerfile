FROM openjdk:8-jre-slim

COPY bin/kafka-gitops /usr/src/kafka-gitops
COPY entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
