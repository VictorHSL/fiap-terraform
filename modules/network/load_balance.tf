resource "aws_lb" "load_balance" {
  name               = "Load-Balance-Tech-Challenge"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.security_group_load_balance.id]

  enable_deletion_protection = false 

  enable_http2       = true
  enable_cross_zone_load_balancing = true

  subnets = [aws_subnet.ext_sub_a_tech_challenge.id, aws_subnet.ext_sub_b_tech_challenge.id]
}

