provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "iac-terraform-state-madeforawscloud"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}