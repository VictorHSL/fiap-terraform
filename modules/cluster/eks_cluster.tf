#Elastic Kubernetes Service - Cluster
resource "aws_eks_cluster" "eks_cluster" {

    name    = var.eks_cluster_name
    version = var.eks_version
    role_arn = "arn:aws:iam::<ID da conta>:role/LabRole"

    vpc_config {

        security_group_ids = [
            aws_security_group.eks_cluster_sg.id
        ]

        subnet_ids = [
            var.internal_subnet_1a_id,
            var.internal_subnet_1b_id
        ]

    }

    tags = {
        "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    }

}