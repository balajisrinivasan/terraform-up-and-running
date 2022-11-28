provider "aws" {
  region = "us-east-1"
}

module "datastore" {
  source = "../../modules/datastore"

  bucket = "iac-terraform-state-madeforawscloud"
  key = "staging-datastore-state"
  env = "staging"
  db_username = "admin"
  db_password = "password123"
}