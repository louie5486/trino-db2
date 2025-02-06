ARG BASE
FROM openjdk:23-jdk-slim AS builder
WORKDIR /root/trino-db2
COPY . /root/trino-db2
RUN apt-get update && apt-get install -y maven
ENV MAVEN_FAST_INSTALL="-DskipTests -Dair.check.skip-all=true -Dmaven.javadoc.skip=true -B -q -T C1"
RUN mvn install $MAVEN_FAST_INSTALL

FROM $BASE
COPY --from=builder --chown=trino:trino /root/trino-db2/target/trino-db2-*/* /usr/lib/trino/plugin/db2/
