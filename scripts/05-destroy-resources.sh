#!/bin/bash
set -e
echo "🧹 FASE 5: Destruyendo la Infraestructura..."
cd environments/dev

read -p "❓ ¿Estás seguro de que quieres destruir TODOS los recursos? (escribe 'destruir' para confirmar): " CONFIRMATION
if [ "$CONFIRMATION" != "destruir" ]; then
    echo "🚫 Operación cancelada."
    exit 1
fi

echo "🗑️ Iniciando la destrucción de todos los recursos..."
terraform destroy -auto-approve

echo "✅ ¡Destrucción completada!"
