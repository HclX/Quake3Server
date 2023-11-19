#!/bin/sh
docker-compose build
docker-compose up -d
docker exec -it ioq3svr sh
docker-compose down

