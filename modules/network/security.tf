resource "aws_security_group" "security_group_load_balance" {
  name_prefix = "Security-Group-Load-Balance-${var.environment}"
  vpc_id = aws_vpc.vpc_tech_challenge.id
  
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}