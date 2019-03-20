FROM alpine

ARG BACKUP_CMD
ARG CRON_SCHEDULE

RUN apk add -u rsync curl
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

RUN mkdir -p /opt && \
    printf "#!/bin/sh\n%s" "$BACKUP_CMD" > /opt/runbackup && \
    chmod +x /opt/runbackup

RUN echo "$CRON_SCHEDULE /opt/runbackup" | crontab - && crontab -l

ENTRYPOINT ["crond", "-f", "-L", "/dev/stdout"]
