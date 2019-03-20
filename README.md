# docker-backup-cron

Copies stuff somewhere else, regularly.

## Basic Usage

```
DATA_TYPE=bind \
DATA_SOURCE=/tmp/backup-test-source \
CRON_SCHEDULE="* * * * *" \
BACKUP_CMD="rsync -vah /data /tmp/destination" \
    docker-compose up --build
```

## Environment Variables

* `DATA_TYPE` - `bind` or `volume`
* `DATA_SOURCE` - either a volume name (with type=volume), or a path on the host
* `BACKUP_CMD` - needs to copy `/data` to wherever you want it
    * `rsync` and `rclone` are available
* `CRON_SCHEDULE` - https://crontab.guru/ - something like `0 * * * *`
