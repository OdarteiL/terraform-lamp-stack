module "network" {
  source                  = "./modules/network"
  project                 = var.project
  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr      = var.public_subnet_cidr
  public_subnet_cidr_az2  = var.public_subnet_cidr_az2
  private_subnet_cidr     = var.private_subnet_cidr
  az                      = var.az
  az2                     = var.az2
}

module "security" {
  source  = "./modules/security"
  project = var.project
  vpc_id  = module.network.vpc_id
}

module "web" {
  source            = "./modules/web"
  project           = var.project
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  public_subnet_id  = module.network.public_subnet_id
  web_sg_id         = module.security.web_sg_id
  key_name          = var.key_name
}

module "db" {
  source              = "./modules/db"
  project             = var.project
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  private_subnet_id   = module.network.private_subnet_id
  db_sg_id            = module.security.db_sg_id
  key_name            = var.key_name
  mysql_root_password = var.mysql_root_password
}

module "bastion" {
  source            = "./modules/bastion"
  project           = var.project
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  public_subnet_id  = module.network.public_subnet_id
  bastion_sg_id     = module.security.bastion_sg_id
  key_name          = var.key_name
}

module "app" {
  source              = "./modules/app"
  project             = var.project
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  private_subnet_id = module.network.private_subnet_id  # use public subnet instead
  key_name            = var.key_name
  app_sg_id           = module.security.app_sg_id
}

resource "aws_lb" "app_alb" {
  name               = "${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.web_sg_id]
  subnets = [
    module.network.public_subnet_id,
    module.network.public_subnet_id_az2
  ]

  tags = {
    Name = "${var.project}-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.project}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project}-tg"
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = module.app.app_instance_id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

