output "alb_dns_name" {
  description = "The domain name of the ALB"
  sensitive   = false
  value       = aws_lb.lb_example.dns_name
}