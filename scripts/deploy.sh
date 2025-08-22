#!/bin/bash
set -e
VERSION=${1:-1.0.0}
ENV=${2:-dev}
NAMESPACE="quarkus-$ENV"

kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
helm upgrade --install quarkus-app ./helm \
  --namespace $NAMESPACE \
  --values values-$ENV.yaml \
  --set image.tag=$VERSION-$ENV \
  --wait
