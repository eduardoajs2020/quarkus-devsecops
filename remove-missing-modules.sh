#!/usr/bin/env bash

set -e

echo "🔧 Removendo módulos ausentes do workflow Maven..."

WORKFLOW_FILE=".github/workflows/native-tests.yml"
MISSING_MODULES=(
  tika-quickstart
  validation-quickstart
  vertx-quickstart
  websockets-quickstart
)

# Verifica se o arquivo existe
if [[ ! -f "$WORKFLOW_FILE" ]]; then
  echo "❌ Arquivo '$WORKFLOW_FILE' não encontrado."
  exit 1
fi

# Faz backup antes de editar
cp "$WORKFLOW_FILE" "${WORKFLOW_FILE}.bak"
echo "📦 Backup criado: ${WORKFLOW_FILE}.bak"

# Remove os módulos da linha que contém -pl
for module in "${MISSING_MODULES[@]}"; do
  sed -i "/-pl/s/,$module//g" "$WORKFLOW_FILE"
done

echo "✅ Módulos removidos com sucesso:"
for module in "${MISSING_MODULES[@]}"; do
  echo "   - $module"
done

echo "📝 Arquivo atualizado: $WORKFLOW_FILE"
