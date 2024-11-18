region = "us-east-1"

#-----------------------------------------------------------
# AWS EKS cluster
#-----------------------------------------------------------
enable = true
eks_cluster_name = "test_cluster"
eks_cluster_enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
eks_cluster_version = null
#vpc_config
subnets = ["",""]
cluster_security_group_id = null 
cluster_endpoint_public_access = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
cluster_endpoint_private_access = false
#timeout
cluster_create_timeout = "30m"
cluster_delete_timeout = "15m"
cluster_update_timeout = "60m"


#---------------------------------------------------
# commantags variable
#---------------------------------------------------

name = "test"
enviroment = "test"
application = "test"
support = "Cloudbuilders"
creater = "CloudBuilders"


#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
enable_eks_node_group = true
eks_node_group_node_group_name = "test_nodegroup"
eks_node_group_subnet_ids = ["",""]
#Scaling Config
max_size     = "3"
desired_size = "2"
min_size     = "2"
eks_node_group_ami_type = "AL2_x86_64"
eks_node_group_disk_size = "20"
eks_node_group_force_update_version = null
eks_node_group_instance_types = ["t3.medium"]
eks_node_group_release_version = null
eks_node_group_version = null

#---------------------------------------------------
# IAM
#---------------------------------------------------

permissions_boundary = null
create_eks_service_role = true 

#---------------------------------------------------
# OIDC
#---------------------------------------------------

client_id = "sts.amazonaws.com"


#--------------------------------------------------------
#
#------------------------------------------------------------