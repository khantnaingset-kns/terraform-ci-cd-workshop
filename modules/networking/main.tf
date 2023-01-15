resource "aws_vpc" "main_vpc" {
  cidr_block           = local.vpc_cidr_block
  instance_tenancy     = local.vpc_instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags = {
    Name = var.vpc_name_tag
  }
}

resource "aws_subnet" "public_subnet_1" {
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.public_subnet_1_cidr_block
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.public_subnet_name_tag}_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
 availability_zone = "${data.aws_availability_zones.available.names[1]}"
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.public_subnet_2_cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.public_subnet_name_tag}_2"
  }
}

resource "aws_subnet" "private_subnet" {
 availability_zone = "${data.aws_availability_zones.available.names[2]}"
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = local.private_subnet_cidr_block

  tags = {
    Name = var.private_subnet_name_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.internet_gateway_name_tag
  }
}

resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = local.public_route_table_allow_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.public_route_table_name_tag}_1"
  }
}

resource "aws_route_table" "public_route_table_2" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = local.public_route_table_allow_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.public_route_table_name_tag}_2"
  }
}



resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table_1.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table_2.id
}


resource "aws_eip" "nat_gateway_ip" {
  vpc = true
}



resource "aws_nat_gateway" "public_ngw" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_gateway_ip.id

  tags = {
    Name = var.public_route_nat_gateway_name_tag
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = local.public_route_table_allow_cidr_block
    gateway_id = aws_nat_gateway.public_ngw.id
  }

  tags = {
    Name = var.private_route_table_name_tag
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

