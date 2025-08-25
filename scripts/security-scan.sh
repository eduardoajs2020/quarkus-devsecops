#!/bin/bash
set -e
echo "Executando Trivy..."
trivy image quarkus-app:latest
echo "Executando Checkov..."
checkov -d k8s/
echo "Executando Grype..."
grype dir:app/
