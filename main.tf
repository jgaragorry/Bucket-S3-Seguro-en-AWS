# Propósito: Contiene la lógica principal para crear todos los recursos de AWS, aplicando las mejores prácticas.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Uso de "locals" para construir nombres y etiquetas consistentes (Buena Práctica DevOps)
locals {
  bucket_name     = "${var.project_name}-${var.environment}-${var.bucket_name_suffix}"
  log_bucket_name = "${local.bucket_name}-logs"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --- Bucket para Logs (Mejor Práctica SysOps/SecOps) ---
# Se crea un bucket separado para almacenar los logs de acceso del bucket principal.
resource "aws_s3_bucket" "log_bucket" {
  bucket = local.log_bucket_name
  tags   = local.common_tags
}

# --- Bucket Principal de Activos ---
resource "aws_s3_bucket" "main_bucket" {
  bucket = local.bucket_name
  tags   = local.common_tags
}

# --- Sección de Configuraciones de Seguridad y Confiabilidad ---

# 1. DevSecOps: Bloquea todo el acceso público por defecto.
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 2. SRE/SysOps: Habilita el versionado para prevenir borrados accidentales y permitir recuperaciones.
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. DevSecOps: Refuerza la encriptación por defecto (SSE-S3) para todos los objetos.
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4. SysOps/SecOps: Habilita el logging de acceso para auditoría y observabilidad.
resource "aws_s3_bucket_logging" "main" {
  bucket = aws_s3_bucket.main_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "access-logs/"
}

# 5. DevSecOps/NetOps: Política que niega cualquier subida de archivos que no sea por una conexión segura (HTTPS).
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "EnforceSecureTransport",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.main_bucket.arn}/*",
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
