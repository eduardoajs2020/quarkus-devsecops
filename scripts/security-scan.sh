#!/bin/bash
set -e
echo "Running security scans..."
trivy image quarkus-app:latest
checkov -d k8s/
grype dir:app/
