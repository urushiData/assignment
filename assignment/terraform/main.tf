provider "aws" {
  region = "ap-northeast-2"
}

module "network" {
  source = "./modules/network"
}

module "security" {
  source         = "./modules/security"
  workstation_ip = "13.53.135.213/32"
  vpc_id         = module.network.vpc_id
}

module "compute" {
  source    = "./modules/compute"
  subnet_id = module.network.subnet_id
  sg_id     = module.security.sg_id
  key_name  = module.security.key_name
}
