#--------------------------------------------------------------------------------#
#       Criação da VPC e da Subnet
#--------------------------------------------------------------------------------#

#VPC - Rede principal utilizada para hospedar as demais subredes.
resource "aws_vpc" "vpc_tech_challenge" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-${var.environment}"
  }
}
#SUB REDE PRIVADA
resource "aws_subnet" "sub_int_a_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_int_a
  availability_zone = var.region_a

  tags = {
    Name = "Subnet-Interna-A-${var.environment}"
  }
}

resource "aws_subnet" "sub_int_b_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_int_b
  availability_zone = var.region_b

  tags = {
    Name = "Subnet-Interna-B-${var.environment}"
  }
}
#SUB REDE PUBLICA
resource "aws_subnet" "sub_ext_a_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_ext_a
  availability_zone = var.region_a

  tags = {
    Name = "Subnet-Externa-A-${var.environment}"
  }
}

resource "aws_subnet" "sub_ext_b_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_ext_b
  availability_zone = var.region_b

  tags = {
    Name = "Subnet-Externa-B-${var.environment}"
  }
}

#INTERNET GATEWAY - Utilizado para deixar a rede externa publica para a internet
resource "aws_internet_gateway" "igw_tech_challenge" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Internet_Gateway-${var.environment}"
  }
}

#(EIP) IPs Elásticos dedicados nas regiões. 
#Esses IPs serão o default de saída de internet dos recursos.
resource "aws_eip" "nat_gateway_eip_a" {
  tags = {
    Name = "IP_Elastico_a-${var.environment}"
  }
}

resource "aws_eip" "nat_gateway_eip_b" {
  tags = {
    Name = "IP_Elastico_b-${var.environment}"
  }
}

#NAT GATEWAY - Utilizado para permitir a navegação de internet das sub redes internas. 
#Vinculamos os IPs Elásticos e as Subredes externas (Não pode ser amarrado a subrede interna)
resource "aws_nat_gateway" "nat_gtw_a" {
  allocation_id = aws_eip.nat_gateway_eip_a.id
  subnet_id     = aws_subnet.sub_ext_a_tech_challenge.id

  tags = {
    Name = "NAT_Gateway_a-${var.environment}"
  }
}

resource "aws_nat_gateway" "nat_gtw_b" {
  allocation_id = aws_eip.nat_gateway_eip_b.id
  subnet_id     = aws_subnet.sub_ext_b_tech_challenge.id

  tags = {
    Name = "NAT_Gateway_b-${var.environment}"
  }
}

#Criação da tabela de rotas das sub redes internas A e B -----------
resource "aws_route_table" "internal_route_table_a" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Tabela_Roteamento_Interna_a-${var.environment}"
  }
}
resource "aws_route_table" "internal_route_table_b" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Tabela_Roteamento_Interna_b-${var.environment}"
  }
}

#Associação das tabelas de rotas de rede A e B com as sub redes 
resource "aws_route_table_association" "roteamento_interno_a" {
  subnet_id      = aws_subnet.sub_int_a_tech_challenge.id
  route_table_id = aws_route_table.internal_route_table_a.id
}

resource "aws_route_table_association" "roteamento_interno_b" {
  subnet_id      = aws_subnet.sub_int_b_tech_challenge.id
  route_table_id = aws_route_table.internal_route_table_b.id
}

#Roteamento interno de saída para a internet da sub rede A e B.
resource "aws_route" "rota_default_internal_sub_net_a" {
  route_table_id         = aws_route_table.internal_route_table_a.id
  destination_cidr_block = var.route_cidr_block

  nat_gateway_id = aws_nat_gateway.nat_gtw_a.id
  depends_on     = [aws_nat_gateway.nat_gtw_a]
}

resource "aws_route" "rota_default_internal_sub_net_b" {
  route_table_id         = aws_route_table.internal_route_table_b.id
  destination_cidr_block = var.route_cidr_block

  nat_gateway_id = aws_nat_gateway.nat_gtw_b.id
  depends_on     = [aws_nat_gateway.nat_gtw_b]
}

#Criação da tabela de rotas das sub redes externas A e B -----------
resource "aws_route_table" "external_route_table_a" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Tabela_Roteamento_Externa_a"
  }
}
resource "aws_route_table" "external_route_table_b" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Tabela_Roteamento_Externa_b"
  }
}

#Associação das tabelas de rotas de rede A e B com as sub redes 
resource "aws_route_table_association" "roteamento_externo_a" {
  subnet_id      = aws_subnet.sub_ext_a_tech_challenge.id
  route_table_id = aws_route_table.external_route_table_a.id
}

resource "aws_route_table_association" "roteamento_externo_b" {
  subnet_id      = aws_subnet.sub_ext_b_tech_challenge.id
  route_table_id = aws_route_table.external_route_table_b.id
}

#Roteamento externo de saída para a internet da sub rede A e B.
resource "aws_route" "rota_default_external_sub_net_a" {
  route_table_id         = aws_route_table.external_route_table_a.id
  destination_cidr_block = var.route_cidr_block

  gateway_id = aws_internet_gateway.igw_tech_challenge.id 
}
resource "aws_route" "rota_default_external_sub_net_b" {
  route_table_id         = aws_route_table.external_route_table_b.id
  destination_cidr_block = var.route_cidr_block

  gateway_id = aws_internet_gateway.igw_tech_challenge.id
}

#-----------------------------------------------------------------------------------------------------------------------#
#                                 CRIAÇÃO DO SECURITY GROUP DO LOAD BALANCE
#-----------------------------------------------------------------------------------------------------------------------#

resource "aws_security_group" "security_group_load_balance" {
  name_prefix = "security_group_load_balance-${var.environment}"
  vpc_id = aws_vpc.vpc_tech_challenge.id
  
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#-----------------------------------------------------------------------------------------------------------------------#
#                                 CRIAÇÃO DO LOAD BALANCE DENTRO DO AMBIENTE EC2                                        #
#-----------------------------------------------------------------------------------------------------------------------#

resource "aws_lb" "load_balance" {
  name               = "load-balance-tech-challenge"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.security_group_load_balance.id]

  enable_deletion_protection = false 

  enable_http2       = true
  enable_cross_zone_load_balancing = true

  subnets = [aws_subnet.sub_ext_a_tech_challenge.id, aws_subnet.sub_ext_b_tech_challenge.id]
}

