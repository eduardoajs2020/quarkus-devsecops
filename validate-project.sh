#!/usr/bin/env bash

set -e

echo "🔍 Validando ambiente e estrutura do projeto Quarkus..."

# 1. Verificar comandos essenciais
for cmd in docker kubectl kind java mvn; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Comando '$cmd' não encontrado. Instale antes de continuar."
  else
    echo "✅ Comando '$cmd' disponível."
  fi
done

# 2. Verificar versão do Java
JAVA_VERSION=$(java -version 2>&1 | grep 'version' | awk -F '"' '{print $2}')
if [[ "$JAVA_VERSION" != 17* ]]; then
  echo "❌ Java 17 não está ativo. Versão atual: $JAVA_VERSION"
else
  echo "✅ Java 17 está ativo."
fi

# 3. Verificar existência do Dockerfile
if [[ ! -f Dockerfile ]]; then
  echo "❌ Arquivo Dockerfile não encontrado no diretório atual."
else
  echo "✅ Dockerfile encontrado."
fi

# 4. Validar módulos do Maven
MODULES=(
  tika-quickstart
  validation-quickstart
  vertx-quickstart
  websockets-quickstart
)

for module in "${MODULES[@]}"; do
  if [[ ! -d "$module" ]]; then
    echo "⚠️ Módulo '$module' não encontrado. Remova do -pl ou corrija o nome."
  else
    echo "✅ Módulo '$module' existe."
  fi
done

# 5. Verificar se pom.xml inclui os módulos
if grep -q "<module>tika-quickstart</module>" pom.xml; then
  echo "✅ 'tika-quickstart' está listado no pom.xml"
else
  echo "⚠️ 'tika-quickstart' não está listado no pom.xml. Maven pode falhar."
fi

echo "✅ Validação concluída."
