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
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
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
  account_id            = var.account_id
  vpc_id                = module.network.vpc_id
  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id

}

module "nodes" {
  source = "./modules/nodes"

  environment      = var.environment
  eks_cluster_name = var.eks_cluster_name
  account_id       = var.account_id

  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id

  eks_cluster    = module.cluster.eks_cluster
  eks_cluster_sg = module.cluster.eks_cluster_sg

  nodes_instances_sizes = var.nodes_instances_sizes
  auto_scale_options    = var.auto_scale_options
}
