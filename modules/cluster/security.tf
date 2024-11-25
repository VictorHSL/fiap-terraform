resource "aws_security_group" "eks_cluster_sg" {

    name = "EKS_Cluster-${var.environment}"
    vpc_id = var.vpc_id

    egress {
        from_port   = 0
        to_port     = 0

        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "EKS_Cluster_Security_Group-${var.environment}"
    }

}