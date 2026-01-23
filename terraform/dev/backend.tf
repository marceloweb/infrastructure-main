terraform {
  backend "s3" {
    bucket         = "xyz-example-app-bucket-terraform-state"
    key            = "example-app/dev/terraform.tfstate"
    region         = "us-east-1"                     
    encrypt        = true
  }
}