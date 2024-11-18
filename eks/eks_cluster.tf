resource "aws_eks_cluster" "eks_cluster" {
  # count = var.enable ? 1 : 0 #

  name     = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.enviroment)}"
  role_arn = element(concat(aws_iam_role.cluster.*.arn, [""]), 0)
  enabled_cluster_log_types = var.eks_cluster_enabled_cluster_log_types
  version                   = var.eks_cluster_version
  tags = module.tags.commantags

  vpc_config {
    security_group_ids      = var.cluster_security_group_id
    subnet_ids              = var.subnets
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }
  timeouts {
    create = var.cluster_create_timeout
    delete = var.cluster_delete_timeout
    update = var.cluster_update_timeout
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

#comman tags
module "tags" {
    source = "../common_tags"
    name = var.name
    enviroment = var.enviroment
    application = var.application
    support = var.support
    creater  =var.creater
    
} 