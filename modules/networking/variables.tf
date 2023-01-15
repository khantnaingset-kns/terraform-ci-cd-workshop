variable "vpc_name_tag" {
  type = string

  description = "Name tag of the vpc"

  default = "ayapay-vpc"
}

variable "public_subnet_name_tag" {
  type = string

  description = "Name tag of the vpc subnet"

  default = "ayapay-public-subnet"
}

variable "private_subnet_name_tag" {
  type = string

  description = "Name tag of the vpc subnet"

  default = "ayapay-private-subnet"
}

variable "internet_gateway_name_tag" {
  type = string

  description = "Name tag of the internet gateway"

  default = "ayapay-igw"
}

variable "public_route_table_name_tag" {
  type = string

  description = "Name tag of the public route table"

  default = "ayapay-public-route-table"
}

variable "private_route_table_name_tag" {
  type = string

  description = "Name tag of the private route table"

  default = "ayapay-private-route-table"
}

variable "public_route_nat_gateway_name_tag" {
  type = string

  description = "Name tag of the Public Nat Gateway"

  default = "ayapay-public-nat-gateway"
}
