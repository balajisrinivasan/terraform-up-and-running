output "asg_name" {
  description = "The domain name of the ALB"
  sensitive   = false
  value       = aws_autoscaling_group.example.name
}