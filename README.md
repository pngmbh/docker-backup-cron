# docker-backup-cron

Copies stuff somewhere else, regularly.

`docker pull ghcr.io/pngmbh/docker-backup-cron`

## Basic Usage

```
docker run \
    -e CRON_SCHEDULE="* * * * *" \
    -v /tmp/backup-test-source:/data:ro \
    -v /tmp/backup-test-destination:/destination \
    quay.io/pngmbh/docker-backup-cron:latest \
    rsync -vah /data/ /destination
```

## Config

* `CRON_SCHEDULE` - https://crontab.guru/ - something like `0 * * * *`
* the docker command needs to be something that copies your data
  to wherever you want it
    * `rsync` and `rclone` are available
