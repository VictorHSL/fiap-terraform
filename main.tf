terraform {
  required_version = ">=1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = "ASIASBPSPDOIXK6EFAAC"
  secret_key = "ga+yCV3BXkX7vLOASwDMSC6H1hkWKvYjmzqLZOKg"
  token      = "IQoJb3JpZ2luX2VjENH//////////wEaCXVzLXdlc3QtMiJIMEYCIQC3cRK4YGKM8RQqi16y2sx0x2f80A8EuTkxclO3E8W7awIhAPaVZipVXsuUMGaFr8QYWranKMS4MHgxGuMK3EuA5QCkKrgCCHoQABoMMTQwNjMxODA4OTEzIgwpZYpmahgsDsETNOsqlQLoyqsT6ayCyRmjkhhYFgMvtoqAoCHdKyG23FP5E0ypwozTAVhB9lZF7a6jm7glNumgBaKEq4yY2c8i4pumDObE3FOIKqh3MZ1mulS1/yyZFtD8MYC95qGYcos5GKnmAhBTDG+Jdd9zT9X/MoTGyYv30xslL/55OFmsOYNd+85pFj9PkTBAzH8eQKZ+qKrYC3YHGU8YnonQZjCgpXnYtQBIQWD3DiNjABWVN2L0iglF8E+Hg7HpfDTJH3iK1omR2bDSm6osvZTaJJhyV49DiDwRYfQrVPaO6YXKLOUnx0sZyZZCWuPzieUtypbQ+aNiWLm6pX3aZZEDKc/s61F8ObjiX8OK4T3KXTL4rptJ1i+XGE3ZeOiiMM7Yp7oGOpwBgw9+CoFwb171IRpnwhQIKXTd8ZHAczaxhUaO10mY30bNnWn7lkjMQPXaxGzIHlN+VY1OEVtcbLgfalFAi7u7OGU60EPhh5j7lWzjktOzkC1ZYOnDP1knddshqdiLSfJKpyq1GQVMSfEZ6Yr1hUnTKhJaY6U7HuqrMY0ATYwgtg/cVd3PfZU2GEemU85AxoziQ8gkUXliSoIV9IiQ"
  
}

module "network" {

  source = "./modules/network"

  cidr_vpc          = "10.110.0.0/16"
  cidr_subnet_int_a = "10.110.1.0/24"
  cidr_subnet_ext_a = "10.110.11.0/24"
  cidr_subnet_int_b = "10.110.2.0/24"
  cidr_subnet_ext_b = "10.110.10.0/24"
  environment       = var.environment
  region_a          = var.region-subnet-a
  region_b          = var.region-subnet-b
  route_cidr_block  = "0.0.0.0/0"
  eks_cluster_name  = var.eks_cluster_name

}

module "cluster" {

  source = "./modules/cluster"

  environment           = var.environment
  aws_region            = var.aws_region
  eks_cluster_name      = var.eks_cluster_name
  eks_version           = var.eks_version
  vpc_id                = module.network.vpc_id
  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id

}

module "nodes" {
  source = "./modules/nodes"

  environment      = var.environment
  eks_cluster_name = var.eks_cluster_name

  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id

  eks_cluster    = module.cluster.eks_cluster
  eks_cluster_sg = module.cluster.eks_cluster_sg

  nodes_instances_sizes = var.nodes_instances_sizes
  auto_scale_options    = var.auto_scale_options
}
