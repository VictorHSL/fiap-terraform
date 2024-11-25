output "eks_cluster" {
  description = "ID do cluster kubernets"
  value       = aws_eks_cluster.eks_cluster
}

output "eks_cluster_sg" {
  description = "ID do grupo de seguranças do cluster kubernets"
  value       = aws_security_group.eks_cluster_sg.id
}
