resource "aws_eks_fargate_profile" "Fargate_test_cluster" {
  cluster_name           = var.eks_cluster_name
  fargate_profile_name   = "fargate_profile"
  pod_execution_role_arn = "pod_execution_role"
  subnet_ids             = ["","e"]

  selector {
    namespace = "test-cluster-pod-namespace1"
  }
} 
