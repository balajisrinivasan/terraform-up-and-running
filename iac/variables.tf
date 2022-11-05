variable "server_port" {
  description = "The port the serve will use for HTTP request"
  type        = number
  default     = 8080
}

variable "myvpc_id" {
  description = "Id of the Myvpc-vpc"
  type        = string
  default     = "vpc-0a4e101a25f454f63"
}