output "web_public_ip" {
  value = module.web.web_public_ip
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "app_instance_id" {
  value = module.app.app_instance_id
}

output "app_private_ip" {
  value = module.app.app_private_ip
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

