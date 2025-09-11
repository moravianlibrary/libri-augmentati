# moravianlibrary/libri-augmentati:1.5.0
# syntax=docker/dockerfile:1-labs
FROM daliboris/morganaxproc-iiise:1.6.15-saxonhe-12.8-jre-21

RUN mkdir /la && \
    mkdir /la/src && \
    mkdir /la/run
# COPY src/includes src/schemas src/xproc src/xquery \
# src/xslt src/catalog.xml README.md /la/

COPY ./src /la/src
COPY ./run/client.xpl ./run/docker-mzk.documents.xml /la/run

 ENTRYPOINT ["bash"]
