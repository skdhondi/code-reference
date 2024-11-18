resource "aws_eks_node_group" "eks_node_group" {
  count = var.enable_eks_node_group ? 1 : 0

  cluster_name     = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.enviroment)}"
  node_group_name = var.eks_node_group_node_group_name != "" ? lower(var.eks_node_group_node_group_name) : "${lower(var.name)}-node-group-${lower(var.enviroment)}"
  node_role_arn   = element(concat(aws_iam_role.node.*.arn, [""]), 0)
  subnet_ids      = var.eks_node_group_subnet_ids
  tags = module.tags.commantags

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  ami_type = var.eks_node_group_ami_type
  // capacity_type        = var.eks_node_group_capacity_type
  disk_size            = var.eks_node_group_disk_size
  force_update_version = var.eks_node_group_force_update_version
  instance_types       = var.eks_node_group_instance_types
  release_version      = var.eks_node_group_release_version
  version              = var.eks_node_group_version

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}