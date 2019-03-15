docker rm -f clair

docker run -d \
	--name clair \
	--network qnet \
	-p 6060:6060 \
	-p 6061:6061 \
	-v `pwd`/clairconfig:/config/ \
	-v `pwd`/clairconfig/certs:/certs \
	quay.io/coreos/clair-jwt:v2.0.8

docker logs -f clair
