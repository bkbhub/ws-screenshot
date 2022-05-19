#! /bin/sh

docker buildx build --load --platform=linux/amd64 -t bkbhub/screenshot:amd64 .
docker buildx build --load --platform=linux/arm64 -t bkbhub/screenshot:arm64 .

docker tag bkbhub/screenshot:amd64 bkbhub/screenshot:amd64-latest
docker tag bkbhub/screenshot:arm64 bkbhub/screenshot:arm64-latest

docker push bkbhub/screenshot:amd64-latest
docker push bkbhub/screenshot:arm64-latest

docker manifest rm bkbhub/screenshot:latest

docker manifest create --amend bkbhub/screenshot:latest bkbhub/screenshot:amd64-latest bkbhub/screenshot:arm64-latest

docker manifest push bkbhub/screenshot:latest
