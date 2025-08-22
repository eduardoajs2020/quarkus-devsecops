#!/bin/bash
set -e
VERSION=${1:-1.0.0}
ENV=${2:-dev}
echo "Building version $VERSION for $ENV"

cd app
./mvnw clean package -DskipTests
docker build -f Dockerfile.multistage -t quarkus-app:$VERSION-$ENV .
docker scan quarkus-app:$VERSION-$ENV
