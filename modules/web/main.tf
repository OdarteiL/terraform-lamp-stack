resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project}-web"
  }
}
