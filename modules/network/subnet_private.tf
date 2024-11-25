#SUB REDE PRIVADA
resource "aws_subnet" "int_sub_a_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_int_a
  availability_zone = var.region_a

  tags = {
    Name = "Subnet-Internal-A-${var.environment}",
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "int_sub_b_tech_challenge" {
  vpc_id            = aws_vpc.vpc_tech_challenge.id
  cidr_block        = var.cidr_subnet_int_b
  availability_zone = var.region_b

  tags = {
    Name = "Subnet-Internal-B-${var.environment}",
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

#Associação das tabelas de rotas de rede A e B com as sub redes 
resource "aws_route_table_association" "internal_route_a" {
  subnet_id      = aws_subnet.int_sub_a_tech_challenge.id
  route_table_id = aws_route_table.internal_route_table_a.id
}

resource "aws_route_table_association" "internal_route_b" {
  subnet_id      = aws_subnet.int_sub_b_tech_challenge.id
  route_table_id = aws_route_table.internal_route_table_b.id
}