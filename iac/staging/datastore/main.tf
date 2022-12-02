provider "aws" {
  region = "us-east-1"
}

module "datastore" {
  source = "../../modules/datastore"

  env         = "staging"
  db_username = "admin"
  db_password = "password123"
}

output "address" {
  value       = module.datastore.address
  description = "Endpoint of mysql db instance"
}

output "port" {
  value       = module.datastore.port
  description = "The port of the mysql db instance"
}

terraform {
  backend "s3" {
    bucket = "iac-terraform-state-madeforawscloud"
    key    = "staging/datastore/terraform.state"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}