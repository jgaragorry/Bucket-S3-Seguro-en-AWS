#!/bin/bash
set -e

PROJECT_NAME="tf-enterprise-foundation"
DYNAMODB_TABLE="${PROJECT_NAME}-tf-locks"
BUCKET_PREFIX="${PROJECT_NAME}-tfstate-"

echo "🧹 Iniciando limpieza de recursos del backend..."

# --- Limpieza de Buckets S3 ---
echo "🔍 Buscando buckets S3 con el prefijo '$BUCKET_PREFIX'..."
BUCKETS=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, '$BUCKET_PREFIX')].Name" --output text)

if [ -z "$BUCKETS" ]; then
    echo "✅ No se encontraron buckets S3 para limpiar."
else
    for bucket in $BUCKETS; do
        echo "🔥 Vaciando todas las versiones de objetos del bucket $bucket..."
        # Este comando elimina todas las versiones de objetos y marcadores de borrado.
        aws s3api delete-objects --bucket $bucket --delete "$(aws s3api list-object-versions --bucket $bucket --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" > /dev/null 2>&1 || true
        aws s3api delete-objects --bucket $bucket --delete "$(aws s3api list-object-versions --bucket $bucket --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')" > /dev/null 2>&1 || true
        
        echo "🗑️ Eliminando bucket S3: $bucket..."
        aws s3api delete-bucket --bucket $bucket
        echo "✅ Bucket $bucket eliminado."
    done
fi

# --- Limpieza de Tabla DynamoDB ---
echo "🔍 Verificando si la tabla DynamoDB '$DYNAMODB_TABLE' existe..."
if aws dynamodb describe-table --table-name "$DYNAMODB_TABLE" > /dev/null 2>&1; then
    echo "🗑️ Eliminando tabla DynamoDB: $DYNAMODB_TABLE..."
    aws dynamodb delete-table --table-name "$DYNAMODB_TABLE"
    echo "⏳ Esperando a que la tabla sea eliminada por completo..."
    aws dynamodb wait table-not-exists --table-name "$DYNAMODB_TABLE"
    echo "✅ Tabla $DYNAMODB_TABLE eliminada."
else
    echo "✅ La tabla DynamoDB no existe, no se necesita limpieza."
fi

echo "✨ ¡Limpieza del backend completada!"
