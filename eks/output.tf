#---------------------------------------------------
# AWS EKS cluster
#---------------------------------------------------
output "eks_cluster_id" {
  description = "The name of the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.id, [""], ), 0)
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.arn, [""], ), 0)
}

output "eks_cluster_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = concat(aws_eks_cluster.eks_cluster.*.endpoint, [""], )
}

output "eks_cluster_identity" {
  description = "Nested attribute containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019."
  value       = concat(aws_eks_cluster.eks_cluster.*.identity, [""], )
}

output "eks_cluster_platform_version" {
  description = "The platform version for the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.platform_version, [""], ), 0)
}

output "eks_cluster_status" {
  description = "TThe status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.status, [""], ), 0)
}

output "eks_cluster_version" {
  description = "The Kubernetes server version for the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.version, [""], ), 0)
}

output "eks_cluster_certificate_authority" {
  description = "Nested attribute containing certificate-authority-data for your cluster."
  value       = concat(aws_eks_cluster.eks_cluster.*.certificate_authority, [""], )
}

output "eks_cluster_vpc_config" {
  description = "Additional nested attributes"
  value       = concat(aws_eks_cluster.eks_cluster.*.vpc_config, [""], )

}

#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.arn, [""], ), 0)
}

output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.id, [""], ), 0)
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.status, [""], ), 0)
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources."
  value       = concat(aws_eks_node_group.eks_node_group.*.resources, [""], )
}

#---------------------------------------------------
# AWS OIDC
#---------------------------------------------------


output "cluster_identity_oidc_issuer_arn" {
  description = "ARN of oidc issuer"
  value = element(concat(aws_iam_openid_connect_provider.oidc.*.arn, [""], ), 0)
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value = flatten(concat(aws_eks_cluster.eks_cluster[*].identity[*].oidc[0].issuer, [""]))[0]

} 
