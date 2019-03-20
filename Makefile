run-test:
	mkdir -p /tmp/backup-test-source
	echo "HELLO" > /tmp/backup-test-source/hello
	DATA_TYPE=bind \
	DATA_SOURCE=/tmp/backup-test-source \
	CRON_SCHEDULE="* * * * *" \
	BACKUP_CMD="rsync -vah /data /tmp/destination" \
		docker-compose up --build
