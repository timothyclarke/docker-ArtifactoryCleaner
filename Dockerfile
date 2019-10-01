FROM alpine:latest

LABEL MAINTAINER="https://github.com/timothyclarke/docker-ArtifactoryCleaner"
COPY ArtifactoryCleaner /bin/ArtifactoryCleaner
RUN set -ex && \
    apk add --no-cache python3 py3-requests && \
    pip3 install natsort && \
    adduser -u 1000 -s /bin/bash -h /home/artifactorycleaner -D artifactorycleaner && \
    chmod +x /bin/ArtifactoryCleaner && \
    chown 1000.1000 /bin/ArtifactoryCleaner
USER artifactorycleaner
ENTRYPOINT ["/bin/ArtifactoryCleaner"]
