provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami = "ami-0149b2da6ceec4bb0"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg_example.id]

    user_data = <<-EOF
                #!bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
    
    user_data_replace_on_change = true

    tags = {
      "Name" = "terraform-example"
    }
}

resource "aws_security_group" "sg_example" {
    name = "terraform-example-security-group"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}