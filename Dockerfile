FROM ubuntu:22.04
RUN apt-get update && apt-get install -y --no-install-recommends \
      bash procps git tar gzip coreutils \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY scripts/ /app/scripts/
RUN chmod +x /app/scripts/*.sh && mkdir -p /app/logs /app/backups /app/data
ENV INTERVAL=60 KEEP_BACKUPS=5
CMD ["/app/scripts/entrypoint.sh"]
