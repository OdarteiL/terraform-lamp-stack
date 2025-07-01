resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/user_data.sh", {
    mysql_root_password = var.mysql_root_password
  })

  tags = {
    Name = "${var.project}-db"
  }
}
