#SUB REDE PUBLICA
resource "aws_subnet" "ext_sub_a_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_ext_a
  availability_zone = var.region_a

  tags = {
    Name = "External_Subnet-A-${var.environment}",
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "ext_sub_b_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_ext_b
  availability_zone = var.region_b

  tags = {
    Name = "External_Subnet-B-${var.environment}",
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

#Associação das tabelas de rotas de rede A e B com as sub redes 
resource "aws_route_table_association" "external_route_a" {
  subnet_id      = aws_subnet.ext_sub_a_tech_challenge.id
  route_table_id = aws_route_table.external_route_table_a.id
}

resource "aws_route_table_association" "external_route_b" {
  subnet_id      = aws_subnet.ext_sub_b_tech_challenge.id
  route_table_id = aws_route_table.external_route_table_b.id
}