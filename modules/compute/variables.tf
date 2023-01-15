variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "public_subnet_id_1" {
  type        = string
  description = "ID of the Public Subnet"
}

variable "public_subnet_id_2" {
  type        = string
  description = "ID of the Public Subnet"
}

variable "private_subnet_id" {
  type        = string
  description = "ID of the Private Subnet"
}


variable "web_server_1_name_tag" {
  type = string

  description = "Name tag of the Web Server 1"

  default = "ayapay-web-server-1"
}

variable "web_server_2_name_tag" {
  type = string

  description = "Name tag of the Web Server 2"

  default = "ayapay-web-server-2"
}

variable "bastion_host_name_tag" {
  type = string

  description = "Name tag of the Bastion Host"

  default = "ayapay-bastion-host"
}

variable "bastion_sg_name_tag" {
  type = string

  description = "Name tag of the Bastion Security Group"

  default = "ayapay-bastion-sg"
}

variable "webserver_sg_name_tag" {
  type = string

  description = "Name tag of the WebServer Security Group"

  default = "ayapay-webserver-sg"
}

variable "ec2_key_pair_name" {
  type = string

  description = "Name of the EC2 Key Pair"

  default = "deployer-key"
}

variable "ec2_key_pair_public_key" {
  type = string

  description = "Public Key of the EC2 Key Pair"

  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCt/Maw4znIR9GtbgpvCF7Pg7sp0Ybis7+Q52x6/551X1aBLYQpxGbwN3/Hz1nGuZoATJQuLqFXbUJIfsxVZslicVoEjJlWWLeJyIbSsORcKaCU4npNT6hsIxLokWl9Z/asqFKjA9fkWeyOvOfam49hvKcgnVXUM13Fi03R6Y7CE5Yd1bFfZU2O67qBMPA+8/7DLeJxmO5bY+1vxfIh+097g2wSE/uVQrNSQ46FVgk6351QFMKk/EMBKy2RlbpaVqNrDoRc7KHH3xSU7hD2utpAdxOABZ3/zWfUugQTfJR80dgL6kI7jbwLmCa45rJn3FYlGSiONZDy7VDZe7uX4U/FaQJf/K16fb7exr2BFt+jbeNMTJUM5JBWYiMsA9/6Ru7RUk1qY+Lj+ELloFkGlR/vnxbmgszb1woZF8NFio/fy/E5sbvZ2QVvEq151xApVo6jhe9E6EpN/qJuE1R9ooo4rmuRlxFMnsRzMRYKVIZOW3EVx/KKwEXv/q1CINPaJF8= khant naing set@CartoCat"
}

variable "target_group_name_tag" {
  type = string

  description = "Name tag of Target Group"

  default = "ayapay-tg"
}

variable "aya_pay_alb_name" {
  type = string

  description = "Name of AyaPay ALB"

  default = "ayapay-alb"
}
