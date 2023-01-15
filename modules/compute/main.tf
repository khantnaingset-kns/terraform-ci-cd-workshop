resource "aws_instance" "web_server_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.private_subnet_id

  key_name = aws_key_pair.deployer.id

  security_groups = [aws_security_group.web_server_sg.id]

  user_data = data.template_file.web_server_init.rendered

  tags = {
    Name = var.web_server_1_name_tag
  }
}

resource "aws_instance" "web_server_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.private_subnet_id

  key_name = aws_key_pair.deployer.id

  security_groups = [aws_security_group.web_server_sg.id]

  user_data = data.template_file.web_server_init.rendered

  tags = {
    Name = var.web_server_2_name_tag
  }
}

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.public_subnet_id_1

  key_name = aws_key_pair.deployer.id

  associate_public_ip_address = true

  security_groups = [aws_security_group.bastion_host_sg.id]

  tags = {
    Name = var.bastion_host_name_tag
  }
}

resource "aws_lb_target_group" "ayapay_tg" {
  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 5
    matcher             = "200"
  }
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  name        = var.target_group_name_tag
}
resource "aws_lb_target_group_attachment" "attachment_1" {
  target_group_arn = aws_lb_target_group.ayapay_tg.arn
  target_id        = aws_instance.web_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment_2" {
  target_group_arn = aws_lb_target_group.ayapay_tg.arn
  target_id        = aws_instance.web_server_2.id
  port             = 80
}

resource "aws_lb" "ayapay_alb" {
  name               = var.aya_pay_alb_name
  internal           = false
  load_balancer_type = "application"
  subnets = [
    var.public_subnet_id_1,
    var.public_subnet_id_2
  ]
  security_groups = [
    aws_security_group.alb_sg.id
  ]
  ip_address_type = "ipv4"
  access_logs {
    enabled = false
    bucket  = ""
    prefix  = ""
  }
  idle_timeout                     = "60"
  enable_deletion_protection       = "false"
  enable_http2                     = "true"
  enable_cross_zone_load_balancing = "true"
}

resource "aws_lb_listener" "ayapay_alb_listener" {
  load_balancer_arn = aws_lb.ayapay_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.ayapay_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "adminpath_rule" {
  priority     = "1"
  listener_arn = aws_lb_listener.ayapay_alb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ayapay_tg.arn
  }
  condition {
    source_ip {
      values = ["116.206.137.18/32"]
    }
  }
  condition {
    path_pattern {
      values = [
        "/"
      ]
    }
  }
}

resource "aws_lb_listener_rule" "rootpath_rule" {
  priority     = "2"
  listener_arn = aws_lb_listener.ayapay_alb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ayapay_tg.arn
  }
  condition {
    path_pattern {
      values = [
        "/"
      ]
    }
  }
}
