resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.app_sg_id]
  associate_public_ip_address = false

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project}-app"
  }
}
