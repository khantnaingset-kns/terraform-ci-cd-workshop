module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source             = "./modules/compute"
  vpc_id             = module.networking.vpc_id
  public_subnet_id_1 = module.networking.public_subnet_1_id
  public_subnet_id_2 = module.networking.public_subnet_2_id
  private_subnet_id  = module.networking.private_subnet_id
}
