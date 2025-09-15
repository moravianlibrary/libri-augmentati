# moravianlibrary/libri-augmentati:1.5.0
# syntax=docker/dockerfile:1-labs

ARG LIBRI_AUGMENTATI_VERSION=1.5.0
ARG JAVA_VERSION=11
ARG MORGANA_VERSION=1.7.1
ARG SAXON_VERSION=12.9

FROM daliboris/morganaxproc-iiise:${MORGANA_VERSION:-1.7.1}-saxonhe-${SAXON_VERSION:-12.9}-jre-${JAVA_VERSION:-21}

ARG LIBRI_AUGMENTATI_VERSION

RUN mkdir /la && \
    mkdir /la/src && \
    mkdir /la/run

# COPY src/includes src/schemas src/xproc src/xquery \
# src/xslt src/catalog.xml README.md /la/

COPY ./src /la/src
COPY ./instructions.txt /la/instructions.txt
COPY ./run/client.xpl ./run/docker-mzk.documents.xml /la/run

# https://specs.opencontainers.org/image-spec/annotations/#pre-defined-annotation-keys
# Specifies the author(s) of the image, including names and/or email addresses, 
# ie. individuals or organization responsible for creating and maintaining the Dockerfile and the container image.
LABEL org.opencontainers.image.authors="Boris Lehečka <boris@daliboris.cz>, <lehecka@mzk.cz>"
# Indicates the organization, company, or entity distributing the image.
LABEL org.opencontainers.image.vendor="Moravská zemská knihovna v Brně"
# Points to the source code repository from which the image was built, ie. source code of the application that is included in the image.
LABEL org.opencontainers.image.source="https://github.com/moravianlibrary/libri-augmentati"
# Links to the general project webpage or related information about the image.
LABEL org.opencontainers.image.url="https://github.com/moravianlibrary/libri-augmentati/README.md"
# Links to the documentation for using, configuring, or deploying the image.
LABEL org.opencontainers.image.documentation="https://github.com/moravianlibrary/libri-augmentati/README.md"
# Specifies the version of the image (e.g., 1.0.0, v2.3.4).
LABEL org.opencontainers.image.version="${LIBRI_AUGMENTATI_VERSION}"
# Provides the name of the image reference, such as a tag or digest, for example 7.0.11-debian-11-r20.
LABEL org.opencontainers.image.ref.name="${LIBRI_AUGMENTATI_VERSION}-${MORGANA_VERSION}morganaxproc-iiise-saxonhe-${SAXON_VERSION}-jre-${JAVA_VERSION}"
LABEL org.opencontainers.image.ref.name="latest"
# Specifies the creation time of the image in ISO 8601 format.
LABEL org.opencontainers.image.created=2025-09-14T17:25:46+02:00
# https://spdx.org/licenses/
# Indicates the license(s) under which the image, ie. the software and applications included in the image, is distributed (e.g., MIT).
LABEL org.opencontainers.image.licenses="GPL-3.0-only, Apache-2.0, BSD-3-Clause-Clear, MPL-2.0, MIT"
# A human-readable title or name for the image.
LABEL org.opencontainers.image.title="Libri augmentati $LIBRI_AUGMENTATI_VERSION, XProc 3.x MorganaXProc-IIIse $MORGANA_VERSION with SaxonHE $SAXON_VERSION, invisible XML by NineML"
# A detailed description of the image, explaining its purpose and functionality.
LABEL org.opencontainers.image.description="Docker image for Libri augmentati XProc 3.x pipelines with MorganaXProc-IIIse $MORGANA_VERSION engine, SaxonHE $SAXON_VERSION, CoffeeGrinder $COFFEEGRINDER_VERSION, CoffeeFilter $COFFEEFILTER_VERSION"
