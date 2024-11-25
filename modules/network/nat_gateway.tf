#(EIP) IPs Elásticos dedicados nas regiões. 
#Esses IPs serão o default de saída de internet dos recursos.
resource "aws_eip" "nat_gateway_eip_a" {
  tags = {
    Name = "Elastick-IP-A-${var.environment}"
  }
}

resource "aws_eip" "nat_gateway_eip_b" {
  tags = {
    Name = "IP_Elastico_B-${var.environment}"
  }
}

#NAT GATEWAY - Utilizado para permitir a navegação de internet das sub redes internas. 
#Vinculamos os IPs Elásticos e as Subredes externas (Não pode ser amarrado a subrede interna)
resource "aws_nat_gateway" "nat_gtw_a" {
  allocation_id = aws_eip.nat_gateway_eip_a.id
  subnet_id     = aws_subnet.ext_sub_a_tech_challenge.id

  tags = {
    Name = "NAT_Gateway_a-${var.environment}"
  }
}

resource "aws_nat_gateway" "nat_gtw_b" {
  allocation_id = aws_eip.nat_gateway_eip_b.id
  subnet_id     = aws_subnet.ext_sub_b_tech_challenge.id

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