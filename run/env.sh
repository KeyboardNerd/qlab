docker rm -f qmysql qpgsql qpma qredis
docker network rm qnet
docker network create qnet

docker run -d \
	--name qpgsql \
	--network qnet \
	-p 5432:5432 \
	postgres:9.6

docker run -d \
	-p 6379:6379 \
	--name qredis \
	--network qnet \
	quay.io/quay/redis

docker ps
