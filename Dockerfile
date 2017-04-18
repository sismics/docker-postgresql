#
# Dockerfile for Postgresql 9.6
#
# Default user is admin/docker

FROM ubuntu:xenial
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install PostgreSQL
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update
RUN apt-get -y -q install python-software-properties software-properties-common postgresql-9.6 postgresql-client-9.6 \
    postgresql-contrib-9.6 postgresql-9.6-postgis-2.3

# Create a superuser admin/docker and set the default encoding to UTF-8
COPY opt /opt
WORKDIR /opt/bin
USER postgres
RUN /etc/init.d/postgresql start &&\
    psql -f /opt/conf/init.sql

# Adjust PostgreSQL configuration so that remote connections to the database are possible
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.6/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.6/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.6/main/postgresql.conf

# Preserve the initial DB to init the data container
USER root
RUN mv /var/lib/postgresql /var/lib/postgresql-init
COPY etc /etc

# Expose the PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["./run.sh"]
