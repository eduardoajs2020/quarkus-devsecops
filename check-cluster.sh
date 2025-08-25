#!/bin/bash

echo "🔍 Verificando status do Minikube..."
minikube status

echo -e "\n🔄 Configurando contexto do kubectl para Minikube..."
kubectl config use-context minikube

echo -e "\n📡 Testando conexão com o servidor Kubernetes..."
kubectl cluster-info || {
  echo "❌ Não foi possível conectar ao cluster. Verifique se o Minikube está iniciado."
  exit 1
}

echo -e "\n📁 Verificando namespaces..."
kubectl get namespaces | grep quarkus || {
  echo "⚠️ Namespaces quarkus-dev e quarkus-prod não encontrados. Criando..."
  kubectl create namespace quarkus-dev
  kubectl create namespace quarkus-prod
}

echo -e "\n📦 Verificando pods no namespace quarkus-dev..."
kubectl get pods -n quarkus-dev

echo -e "\n🌐 Verificando serviços no namespace quarkus-dev..."
kubectl get svc -n quarkus-dev

echo -e "\n✅ Diagnóstico completo!"
