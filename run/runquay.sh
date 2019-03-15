docker rm -f quay
docker run -d \
	-p 443:443 -p 80:80 \
	--env DEBUGLOG=true \
	--name quay \
	--network qnet \
	--privileged \
	-v `pwd`/stack:/conf/stack \
	-v `pwd`/storage:/datastorage \
	qlocal:latest

docker exec quay tail -f /var/log/syslog