# IAM

# CLUSTER
resource "aws_iam_role" "cluster" {
  count = var.create_eks_service_role ? 1 : 0
  name = "${var.eks_cluster_name}-eks-cluster-role"
  tags = module.tags.commantags
  permissions_boundary = var.permissions_boundary

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  count = var.create_eks_service_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = element(concat(aws_iam_role.cluster.*.name, [""]), 0)
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSServicePolicy" {
  count = var.create_eks_service_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = element(concat(aws_iam_role.cluster.*.name, [""]), 0)
}

# NODES
resource "aws_iam_role" "node" {
  count = var.create_eks_service_role ? 1 : 0
  name = "${var.eks_cluster_name}-eks-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  count = var.create_eks_service_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = element(concat(aws_iam_role.node.*.name, [""]), 0)
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  count = var.create_eks_service_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = element(concat(aws_iam_role.node.*.name, [""]), 0)
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  count = var.create_eks_service_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = element(concat(aws_iam_role.node.*.name, [""]), 0)
}

/* Commented until access provided to perform "iam:AddRoleToInstanceProfile" */

resource "aws_iam_instance_profile" "node" {
  name = "${var.eks_cluster_name}-eks-node-instance-profile"
  role = element(concat(aws_iam_role.node.*.name, [""]), 0)
}   



data "tls_certificate" "eks_cluster" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
