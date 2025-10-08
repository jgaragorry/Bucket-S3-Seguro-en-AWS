# Propósito: Declara las variables de entrada que nuestro código necesitará para ser reutilizable.

variable "aws_region" {
  description = "Región de AWS para el despliegue."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto, usado para nombrar y etiquetar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (ej. dev, prod)."
  type        = string
}

variable "bucket_name_suffix" {
  description = "Sufijo único y aleatorio para el nombre del bucket S3."
  type        = string
}
