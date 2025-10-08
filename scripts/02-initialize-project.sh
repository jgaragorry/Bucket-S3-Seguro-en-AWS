#!/bin/bash
set -e
echo "🔧 FASE 2: Inicializando y Planificando el Proyecto Terraform..."
cd environments/dev

echo "🔄 Inicializando Terraform con la nueva configuración de backend..."
# Añadimos -reconfigure para decirle a Terraform que use la nueva
# configuración del backend sin intentar migrar un estado antiguo.
terraform init -reconfigure

echo "✅ Validando la sintaxis del código..."
terraform validate

echo "📋 Generando un plan de ejecución para revisión..."
terraform plan -out=tfplan

echo "✅ ¡Inicialización y planificación completadas!"
