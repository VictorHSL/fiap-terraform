variable "cidr_vpc" {
    description = "Encaminhamento Entre Domínios Sem Classificação (CIDR) para a VPC criada"
    type = string
}
variable "cidr_subnet_int_a" {
    description = "CIDR para a subnet interna A criada - Rede Privada"
    type = string
}
variable "cidr_subnet_int_b" {
    description = "CIDR para a subnet interna B criada - Rede Privada"
    type = string
}
variable "cidr_subnet_ext_a" {
    description = "CIDR para a subnet externa A criada - Rede Pública"
    type = string
}
variable "cidr_subnet_ext_b" {
    description = "CIDR para a subnet externa B criada - Rede Pública"
    type = string
}
variable "environment" {
    description = "Ambiente do recurso"
    type = string
    default = "Tech_Challenge"
}
variable "region_a" {
    description = "Região A do recurso"
    type = string
    default = "us-east-2a"
}
variable "region_b" {
    description = "Região A do recurso"
    type = string
    default = "us-east-2b"
}
variable "route_cidr_block" {
    description = "CIDR de destino para roteamento"
    type = string
}