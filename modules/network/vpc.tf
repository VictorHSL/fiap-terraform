#VPC - Rede principal utilizada para hospedar as demais subredes.
resource "aws_vpc" "vpc_tech_challenge" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-${var.environment}"
  }
}