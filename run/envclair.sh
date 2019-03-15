docker rm -f cpgsql

docker run -d \
	--name cpgsql \
	--network qnet \
	-p 5433:5432 \
	postgres:9.6
