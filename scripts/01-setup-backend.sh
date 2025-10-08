#!/bin/bash
set -e
echo "🚀 FASE 1: Configurando Backend Seguro para Terraform..."

AWS_REGION="us-east-1"
PROJECT_NAME="tf-s3-lab-backend" # Un nombre de proyecto diferente para el backend
TIMESTAMP=$(date +%s)
TERRAFORM_BUCKET="${PROJECT_NAME}-tfstate-${TIMESTAMP}"
DYNAMODB_TABLE="${PROJECT_NAME}-tf-locks"
# CORRECCIÓN: Apunta al directorio raíz actual (.)
BACKEND_CONFIG_FILE="backend.tf"

echo "📦 Creando bucket S3 '$TERRAFORM_BUCKET'..."
aws s3api create-bucket --bucket "$TERRAFORM_BUCKET" --region "$AWS_REGION"

echo "🛡️ Habilitando el versionado en el bucket..."
aws s3api put-bucket-versioning --bucket "$TERRAFORM_BUCKET" --versioning-configuration Status=Enabled

echo "🔒 Creando tabla DynamoDB '$DYNAMODB_TABLE' para bloqueo..."
aws dynamodb create-table \
    --table-name "$DYNAMODB_TABLE" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region "$AWS_REGION" > /dev/null

echo "📝 Generando archivo de configuración del backend..."
cat > "$BACKEND_CONFIG_FILE" << EOF
# Este archivo es generado automáticamente. NO MODIFICAR MANUALMENTE.
terraform {
  backend "s3" {
    bucket  = "$TERRAFORM_BUCKET"
    key     = "global/s3-lab/terraform.tfstate"
    region  = "$AWS_REGION"
    encrypt = true
  }
}
EOF

echo "✅ ¡Configuración del Backend completada!"
