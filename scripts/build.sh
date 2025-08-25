#!/bin/bash

VERSION=$1
ENV=$2

echo "Building version $VERSION for $ENV"

# Corrigido: executa o mvnw da raiz e aponta para o pom.xml dentro de app/
./mvnw -f app/pom.xml clean package -DskipTests

# Criação da imagem Docker
docker build -f Dockerfile.multistage -t quarkus-app:$VERSION-$ENV .

