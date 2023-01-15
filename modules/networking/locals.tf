locals {
  vpc_instance_tenancy                = "default"
  vpc_cidr_block                      = "10.0.0.0/16"
  public_subnet_1_cidr_block          = "10.0.1.0/24"
  public_subnet_2_cidr_block          = "10.0.2.0/24"
  private_subnet_cidr_block           = "10.0.3.0/24"
  public_route_table_allow_cidr_block = "0.0.0.0/0"
}
