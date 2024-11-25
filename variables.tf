variable "access_key" {
    description = "Aws access key"
    type = string
    default = "AKIAZI2LE2LLWR7IBYPF"
}
variable "secret_key" {
    description = "Aws secret key"
    type = string
    default = "nMi6tKOGwqMM1rdmStaIa2y6SiR6a1jFiMwPcezJ"
}
variable "aws_region" {
    description = "Região dos recursos"
    type = string
    default = "us-east-2"
}
variable "region-subnet-a" {
    description = "Região da subnet a"
    type = string
    default = "us-east-2a"
}
variable "region-subnet-b" {
    description = "Região da subnet b"
    type = string
    default = "us-east-2b"
}
variable "environment" {
    description = "Ambiente do recurso"
    type = string
    default = "Tech-Challenge"
}
variable "eks_cluster_name" {
    description = "Nome da Cluster do Elastic Kubernetes Service"
    type = string
    default = "Backend-Tech-Challenge"
}
variable "eks_version" {
  default = "1.30"
}
variable "nodes_instances_sizes" {
  default = [
    "t3.large"
  ]
}

variable "auto_scale_options" {
  default = {
    min     = 2
    max     = 10
    desired = 2
  }
}