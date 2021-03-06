FROM alpine:latest AS builder

COPY runJupyter.sh /usr/local/bin/runJupyter.sh
RUN apk add --virtual .dos2unix dos2unix && \
    dos2unix /usr/local/bin/runJupyter.sh && \
    apk del .dos2unix && \
    chmod +x /usr/local/bin/runJupyter.sh

FROM electronioncollider/pythia-eic-tutorial:latest

ARG BUILD_DATE
ARG SOURCE_COMMIT
LABEL maintainer="Konrad Botor (kbotor@gmail.com)" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="pythia-eic-tutorial" \
      org.label-schema.description="Modification of electronioncollider/pythia-eic-tutorial that allows it to run on Docker for Windows and Docker Toolbox" \
      org.label-schema.url="https://github.com/Forinil/pythia-eic-tutorial" \
      org.label-schema.vcs-ref=$SOURCE_COMMIT \
      org.label-schema.vcs-url="https://github.com/Forinil/pythia-eic-tutorial" \
      org.label-schema.vendor="Konrad Botor" \
      org.label-schema.version="1.0" \
      org.label-schema.schema-version="1.0"
COPY --from=builder /usr/local/bin/runJupyter.sh /usr/local/bin/runJupyter.sh

CMD ["/bin/sh" "-c" "/usr/local/bin/runJupyter.sh"]