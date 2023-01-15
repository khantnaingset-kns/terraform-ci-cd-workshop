output "vpc_id" {
    value = aws_vpc.main_vpc.id
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}


output "nat_gateway_ip" {
  value = aws_eip.nat_gateway_ip.public_ip
}