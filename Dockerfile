#
# Dockerfile for Postgresql 9.6
#
# Instructions:
#
# docker build -t sismics/postgresql .
# docker run -d -p 5432:5432 --name postgresql --volumes-from=postgresql_data sismics/postgresql
#
# Default user is admin/docker

FROM ubuntu:xenial
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install PostgreSQL
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update
RUN apt-get -y -q install python-software-properties software-properties-common postgresql-9.6 postgresql-client-9.6 postgresql-contrib-9.6

# Create a superuser admin/docker and set the default encoding to UTF-8
ADD opt /opt
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
ADD etc /etc

# Expose the PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["./run.sh"]
