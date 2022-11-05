output "example_instance_public_ip" {
    description = "Public ip address of example ec2 instance"
    sensitive = false
    value = aws_instance.example.public_ip
}