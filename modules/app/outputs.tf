output "app_instance_id" {
  value = aws_instance.app.id
}

output "app_private_ip" {
  value = aws_instance.app.private_ip
}
