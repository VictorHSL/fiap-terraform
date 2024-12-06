resource "aws_eks_access_entry" "access_entry" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    principal_arn = "arn:aws:iam::${var.account_id}:role/voclabs"
    kubernetes_groups = ["fiap"]
    type = "STANDARD"
}