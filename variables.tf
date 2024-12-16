variable "access_key" {
  description = "Aws access key"
  type        = string
  default     = "{access_key}"
}
variable "secret_key" {
  description = "Aws secret key"
  type        = string
  default     = "{secret_key}"
}
variable "account_id" {
  description = "Aws account id"
  type        = string
  default     = "{account_id}"
}
variable "session_token" {
  description = "Aws session token"
  type        = string
  default     = "{session token}"
}
variable "aws_region" {
  description = "Região dos recursos"
  type        = string
  default     = "us-east-1"
}
variable "region-subnet-a" {
  description = "Região da subnet a"
  type        = string
  default     = "us-east-1a"
}
variable "region-subnet-b" {
  description = "Região da subnet b"
  type        = string
  default     = "us-east-1b"
}
variable "environment" {
  description = "Ambiente do recurso"
  type        = string
  default     = "Tech-Challenge"
}
variable "eks_cluster_name" {
  description = "Nome da Cluster do Elastic Kubernetes Service"
  type        = string
  default     = "Backend-Tech-Challenge"
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