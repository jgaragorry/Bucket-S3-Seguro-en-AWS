#!/bin/bash
set -e
echo "💰 FASE 4: Generando Informes de Costos (FinOps)..."
START_DATE=$(date -d "7 days ago" +%Y-%m-%d)
END_DATE=$(date +%Y-%m-%d)

echo "📊 Informe de costos por servicio para el proyecto en los últimos 7 días:"
aws ce get-cost-and-usage \
    --time-period Start=$START_DATE,End=$END_DATE \
    --granularity DAILY \
    --metrics "BlendedCost" \
    --group-by Type=DIMENSION,Key=SERVICE \
    --filter '{ "Tags": { "Key": "Project", "Values": ["tf-enterprise-foundation"] } }' \
    --output table \
    || echo "⚠️ Los datos de costos pueden tardar hasta 24 horas en estar disponibles."

echo "✅ ¡Generación de informes completada!"
