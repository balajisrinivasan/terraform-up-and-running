variable "db_username" {
  description = "Username for the mysql database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the mysql database"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}