#!/bin/bash
set -e

VERSION=${1:-1.0.0}
ENV=${2:-dev}
NAMESPACE="quarkus-$ENV"

echo "🚀 Implantando versão $VERSION para ambiente $ENV no namespace $NAMESPACE"

# Garante que o Minikube está usando a imagem local
eval $(minikube docker-env)

# Verifica se a imagem está disponível localmente
if ! docker images | grep -q "quarkus-app.*$VERSION-$ENV"; then
  echo "❌ Imagem quarkus-app:$VERSION-$ENV não encontrada. Execute o build antes."
  exit 1
fi

# Garante que o namespace existe
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Executa o deploy via Helm
helm upgrade --install quarkus-app ./helm \
  --namespace $NAMESPACE \
  --values values-$ENV.yaml \
  --set image.tag=$VERSION-$ENV \
  --set image.repository=quarkus-app \
  --set image.pullPolicy=IfNotPresent \
  --wait

echo "✅ Deploy concluído com sucesso!"
