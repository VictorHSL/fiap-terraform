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
  region     = "us-east-2"
  access_key = "AKIAZI2LE2LLWR7IBYPF"
  secret_key = "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"
}

module "network" {
  source = "./network"

  cidr_vpc          = "10.110.0.0/16"
  cidr_subnet_int_a = "10.110.1.0/24"
  cidr_subnet_ext_a = "10.110.11.0/24"
  cidr_subnet_int_b = "10.110.2.0/24"
  cidr_subnet_ext_b = "10.110.10.0/24"
  environment       = "tech_challenge"
  region_a          = "us-east-2a"
  region_b          = "us-east-2b"
  route_cidr_block  = "0.0.0.0/0"
}
