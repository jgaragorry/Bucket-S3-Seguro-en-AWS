# Este archivo es generado automáticamente. NO MODIFICAR MANUALMENTE.
terraform {
  backend "s3" {
    bucket  = "tf-s3-lab-backend-tfstate-1759949791"
    key     = "global/s3-lab/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
