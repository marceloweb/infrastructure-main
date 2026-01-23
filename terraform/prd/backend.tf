terraform {
  backend "s3" {
    bucket         = "teste-gl-bucket-terraform-state"
    key            = "example-app/prd/terraform.tfstate"
    region         = "us-east-1"                     
    encrypt        = true
  }
}