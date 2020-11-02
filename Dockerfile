FROM registry.access.redhat.com/ubi8/python-38

ENV KEYCLOAK_VERSION 11.0.2
ENV JDBC_POSTGRES_VERSION 42.2.5
ENV JDBC_MYSQL_VERSION 8.0.19
ENV JDBC_MARIADB_VERSION 2.5.4
ENV JDBC_MSSQL_VERSION 7.4.1.jre11

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG GIT_REPO
ARG GIT_BRANCH
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

USER root
RUN dnf update -y && dnf install -y glibc-langpack-en gzip hostname java-11-openjdk-headless openssl tar which && dnf clean all
ADD tools /opt/jboss/tools
RUN /opt/jboss/tools/build-keycloak.sh

USER 1000
EXPOSE 8080
EXPOSE 8443

# Add admin cli to PATH
ENV PATH "${JBOSS_HOME}/bin:${PATH}"

# Install required python packages if any
ADD requirements.txt .
RUN pip install -r requirements.txt

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
