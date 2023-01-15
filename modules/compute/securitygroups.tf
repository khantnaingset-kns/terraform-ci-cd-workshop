resource "aws_security_group" "alb_sg" {
  name        = "Allow Traffic to ALB"
  description = "Allow ALB inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.alb_inbound_cidr
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.alb_inbound_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.outbound_cidr

  }

  tags = {
    Name = var.bastion_sg_name_tag
  }
}

resource "aws_security_group" "bastion_host_sg" {
  name        = "Allow SSH Bastion Host"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.bastion_host_inbount_cidr
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.outbound_cidr

  }

  tags = {
    Name = var.bastion_sg_name_tag
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "Web Server Security Group"
  description = "Allow SSH, HTTP and HTTPS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from Bastion Host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.outbound_cidr

  }

  tags = {
    Name = var.webserver_sg_name_tag
  }
}
