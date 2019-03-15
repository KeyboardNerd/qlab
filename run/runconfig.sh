docker rm -f qconfig
docker run -d \
	-p 444:443 \
	--env DEBUGLOG=true \
	--name qconfig \
	--network qnet \
	--privileged \
	-v `pwd`/stack:/conf/stack \
	-v `pwd`/storage:/datastorage \
	qlocal:latest config

docker exec quay tail -f /var/log/syslog