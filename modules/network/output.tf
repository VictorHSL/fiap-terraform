output "vpc_id" {
    description = "ID da vpc"
    value = aws_vpc.vpc_tech_challenge.id
}
output "ext_subnet_a_id" {
    description = "ID da subnet externa a"
    value = aws_subnet.ext_sub_a_tech_challenge.id
}
output "ext_subnet_b_id" {
    description = "ID da subnet externa b"
    value = aws_subnet.ext_sub_b_tech_challenge.id
}
output "int_subnet_a_id" {
    description = "ID da subnet interna a"
    value = aws_subnet.int_sub_a_tech_challenge.id
}
output "int_subnet_b_id" {
    description = "ID da subnet interna b"
    value = aws_subnet.int_sub_b_tech_challenge.id
}
output "api_gatewaey" {
    description = "ID do gateway"
    value = aws_internet_gateway.igw_tech_challenge.id
}
output "eip_a" {
    description = "ID do ip elastico a"
    value = aws_eip.nat_gateway_eip_a.id
}
output "eip_b" {
    description = "ID do ip elastico b"
    value = aws_eip.nat_gateway_eip_b.id
}
output "nat_gateway_a" {
    description = "ID do NAT a"
    value = aws_nat_gateway.nat_gtw_a
}
output "nat_gateway_b" {
    description = "ID do NAT b"
    value = aws_nat_gateway.nat_gtw_a
}
output "security_groups" {
    description = "ID do grupo de segurança do load balance"
    value = aws_security_group.security_group_load_balance.id
}
output "load_balance" {
    description = "ID do load balance"
    value = aws_lb.load_balance
}