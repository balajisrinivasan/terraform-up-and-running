provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami = "ami-0149b2da6ceec4bb0"
    instance_type = "t2.micro"

    tags = {
      "Name" = "terraform-example"
    }
}