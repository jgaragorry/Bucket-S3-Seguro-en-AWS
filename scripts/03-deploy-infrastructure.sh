#!/bin/bash
set -e
echo "🏗️ FASE 3: Desplegando la Infraestructura..."
cd environments/dev

echo "🚀 Aplicando el plan de Terraform..."
terraform apply -auto-approve tfplan

echo "📊 Mostrando los outputs del despliegue..."
terraform output

echo "✅ ¡Despliegue completado!"
