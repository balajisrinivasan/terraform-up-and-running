provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "iac-terraform-state-madeforawscloud"
    key    = "staging/webserver/terraform.state"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "iac-terraform-state-madeforawscloud"
    key    = "staging/datastore/terraform.state"
    region = "us-east-1"
  }
}

module "webserver_cluster" {
  source = "../../../modules/services"

  env          = "staging"
  cluster_name = "webservers-stage"
  db_address   = data.terraform_remote_state.db.outputs.address
  db_port      = data.terraform_remote_state.db.outputs.port
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scaleout-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 5
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale_in_at_night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}