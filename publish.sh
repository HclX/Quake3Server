#!/bin/sh
VERSION=v0.3
docker build -t hclx/q3svr:$VERSION .
docker tag hclx/q3svr:$VERSION hclx/q3svr:latest
docker push hclx/q3svr:$VERSION
docker push hclx/q3svr:latest

