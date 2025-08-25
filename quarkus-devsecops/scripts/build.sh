#!/bin/bash
set -e

VERSION=${1:-1.0.0}
ENV=${2:-dev}
echo "🔧 Building version $VERSION for $ENV"

# Executa Maven da raiz, apontando para o pom.xml dentro de app/
./mvnw -f app/pom.xml clean package -DskipTests

# Constrói a imagem usando a raiz como contexto
docker build -f Dockerfile.multistage -t quarkus-app:$VERSION-$ENV .

# Opcional: escaneia a imagem com Docker Scan
docker scan quarkus-app:$VERSION-$ENV
