#!/bin/bash
set -e

VERSION=${1:-1.0.0}
ENV=${2:-dev}
NAMESPACE="quarkus-$ENV"

echo "🚀 Implantando versão $VERSION para ambiente $ENV no namespace $NAMESPACE"

# Garante que o namespace existe
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Garante que a imagem está disponível no Minikube
echo "📦 Verificando imagem local..."
docker images | grep "quarkus-app.*$VERSION-$ENV" || {
  echo "❌ Imagem quarkus-app:$VERSION-$ENV não encontrada. Execute o build antes."
  exit 1
}

# Executa o deploy via Helm
helm upgrade --install quarkus-app ./helm \
  --namespace $NAMESPACE \
  --values values-$ENV.yaml \
  --set image.tag=$VERSION-$ENV \
  --wait

echo "✅ Deploy concluído com sucesso!"
