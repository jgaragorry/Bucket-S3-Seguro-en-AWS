# Propósito: Muestra información importante (como los nombres de los buckets) después de un despliegue exitoso.

output "main_bucket_name" {
  description = "Nombre del bucket S3 principal."
  value       = aws_s3_bucket.main_bucket.id
}

output "log_bucket_name" {
  description = "Nombre del bucket S3 para logs."
  value       = aws_s3_bucket.log_bucket.id
}
