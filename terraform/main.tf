# dev-infrastructure
module "dev-infra" {
  source = "./infra"
  env = "dev"
  instance_count = 2
  instance_type = "t2.micro"
  instance_volume_size = 8
}

# stg-infrastructure
module "stg-infra" {
  source = "./infra"
  env = "stg"
  instance_count = 2
  instance_type = "t2.micro"
  instance_volume_size = 8
}

# prod-infrastructure
module "prod-infra" {
  source = "./infra"
  env = "prod"
  instance_count = 3
  instance_type = "t2.micro"
  instance_volume_size = 8
}


output "dev_infra_instance_public_ips" {
  value = module.dev-infra.instance_public_ips
}

output "stg_infra_instance_public_ips" {
  value = module.stg-infra.instance_public_ips
}

output "prod_infra_instance_public_ips" {
  value = module.prod-infra.instance_public_ips
}