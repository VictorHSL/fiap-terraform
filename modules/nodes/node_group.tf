resource "aws_eks_node_group" "eks_node_group" {

  cluster_name    = var.eks_cluster.name
  node_group_name = "EKS_Node_Group-${var.environment}"
  
  node_role_arn   = "arn:aws:iam::${var.account_id}:role/LabRole"

  subnet_ids = [
    var.internal_subnet_1a_id,
    var.internal_subnet_1b_id
  ]

  instance_types = var.nodes_instances_sizes

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }
}
