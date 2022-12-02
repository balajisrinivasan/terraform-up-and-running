variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

variable "env" {
  description = "Environment name for the provisioned resource"
  type        = string
}

variable "db_address" {
  description = "The name of the S3 bucket of for the database's remote state"
  type        = string
}

variable "db_port" {
  description = "The path for the database's remote state in s3"
  type        = string
}