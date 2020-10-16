
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-alpine-Redis/6.0/docker-compose.yaml -o $PWD/docker-compose-redis.yaml
docker-compose -f $PWD/docker-compose-redis.yaml up -d
