FROM debian:stable-slim

ENV OMNIDB_VERSION=2.15.0
ENV SERVICE_USER=omnidb

WORKDIR /${SERVICE_USER}

RUN  adduser --system --home /${SERVICE_USER} --no-create-home ${SERVICE_USER} \
  && mkdir -p /${SERVICE_USER} \
  && chown -R ${SERVICE_USER}.root /${SERVICE_USER} \
  && chmod -R g+w /${SERVICE_USER} \
  && apt-get update \
  && apt-get install -y curl unzip dumb-init \
  && if [ ! -e '/bin/systemctl' ]; then ln -s /bin/echo /bin/systemctl; fi

RUN curl -fsSLk https://omnidb.org/dist/${OMNIDB_VERSION}/omnidb-server_${OMNIDB_VERSION}-debian-amd64.deb --output omnidb-server_${OMNIDB_VERSION}-debian-amd64.deb
RUN dpkg -i omnidb-server_${OMNIDB_VERSION}-debian-amd64.deb
RUN rm -rf omnidb-server_${OMNIDB_VERSION}-debian-amd64.deb

RUN yes | apt-get install alien libaio1
COPY bin/ /app/bin/
RUN alien -i /app/bin/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
RUN alien -i /app/bin/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm
RUN alien -i /app/bin/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
RUN echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle.conf
RUN ldconfig

USER ${SERVICE_USER}
  
EXPOSE 8080
EXPOSE 25482

ENTRYPOINT ["omnidb-server", "--host=0.0.0.0", "--port=8080"]