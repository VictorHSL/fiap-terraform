#INTERNET GATEWAY - Utilizado para deixar a rede externa publica para a internet
resource "aws_internet_gateway" "igw_tech_challenge" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "Internet-Gateway-${var.environment}"
  }
}

#Criação da tabela de rotas das sub redes externas A e B -----------
resource "aws_route_table" "external_route_table_a" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "External-Route-Table-A"
  }
}
resource "aws_route_table" "external_route_table_b" {
  vpc_id = aws_vpc.vpc_tech_challenge.id

  tags = {
    Name = "External-Route-Table-B"
  }
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