TEST_IMG_NAME=docker-backup-cron:test

.PHONY: all test build test-prepare test-start test-assert
all: test

test:
	$(MAKE) test-start
	$(MAKE) test-assert

build:
	docker build -t $(TEST_IMG_NAME) .

test-prepare:
	-docker kill docker-backup-cron-test
	-docker rm docker-backup-cron-test
	mkdir -p /tmp/backup-test-source
	echo "HELLO" > /tmp/backup-test-source/hello
	mkdir -p /tmp/backup-test-destination
	rm -f /tmp/backup-test-destination/hello

test-start: test-prepare build
	docker run --name docker-backup-cron-test -d \
		-e CRON_SCHEDULE="* * * * *" \
		-v /tmp/backup-test-source:/data:ro \
		-v /tmp/backup-test-destination:/destination \
		$(TEST_IMG_NAME) \
		rsync -vah /data/ /destination
	sleep 2
	docker logs docker-backup-cron-test

test-assert:
	docker inspect docker-backup-cron-test > /dev/null # is it running
	grep -q HELLO /tmp/backup-test-destination/hello # did it copy the file
	-docker kill docker-backup-cron-test
	-docker rm docker-backup-cron-test
