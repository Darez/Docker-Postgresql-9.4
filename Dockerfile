FROM centos:centos7
MAINTAINER Darez

RUN rpm -i http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-2.noarch.rpm

RUN yum -y update
RUN yum clean all
RUN yum install -y postgresql93-server postgresql93-contrib
RUN yum clean all

RUN su - postgres -c '/usr/pgsql-9.3/bin/initdb -D /var/lib/pgsql/data'

RUN echo "host    all             all             0.0.0.0/0            md5" >> /var/lib/pgsql/data/pg_hba.conf

RUN echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf

EXPOSE 5432

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"] 
