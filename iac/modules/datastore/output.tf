output "address" {
  value       = aws_db_instance.example.address
  description = "Endpoint of mysql db instance"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port of the mysql db instance"
}