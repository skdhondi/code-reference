
#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

#-----------------------------------------------------------
# AWS EKS cluster
#-----------------------------------------------------------
variable "enable" {
  description = "Enable creating AWS EKS cluster"
  default     = true
}

variable "k8s-version" {
  default     = "1.20"
  type        = string
  description = "Required K8s version"
}
variable "eks_cluster_name" {
  description = "Custom name of the cluster."
  default     = ""
}

variable "eks_cluster_enabled_cluster_log_types" {
  description = "(Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging"
  default     = [ ]
  type        = list
}  

variable "eks_cluster_version" {
  description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  default     = "1.20"
}

 #vpc Config

variable "cluster_security_group_id" {
  description = "If provided, the EKS cluster will be attached to this security group. If not given, a security group will be created with necessary ingress/egress to work with the workers"
  type        = list(string)
  default     = []
}


variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
  default     = ["",""]
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/16", "0.0.0.0/24"]
}
variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}
variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

#timeout
variable "cluster_create_timeout" {
  description = "Timeout value when creating the EKS cluster."
  type        = string
  default     = " "
}

variable "cluster_delete_timeout" {
  description = "Timeout value when deleting the EKS cluster."
  type        = string
  default     = " "
}

variable "cluster_update_timeout" {
  description = "Timeout value when updating the EKS cluster."
  type        = string
  default     = " "
}
/*
variable "create_before_destroy" {
  description = "lycycle create_before_destroy"
  type = bool
  default = true
  
}*/
#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
variable "enable_eks_node_group" {
  description = "Enable EKS node group usage"
  default     = true
}

variable "eks_node_group_node_group_name" {
  description = "Name of the EKS Node Group."
  default     = ""
}
variable "eks_node_group_subnet_ids" {
  description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
  default     = ["",""]
}

#Scaling_config
variable "desired_size" {
  default     = " "
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max_size" {
  default     = " "
  type        = string
  description = "Autoscaling maximum node capacity"
}

variable "min_size" {
  default     = " "
  type        = string
  description = "Autoscaling Minimum node capacity"
}


variable "eks_node_group_ami_type" {
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided."
  default     = " "
}

variable "eks_node_group_disk_size" {
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
  default     = " "
}

variable "eks_node_group_force_update_version" {
  description = "(Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  default     = null
}

variable "eks_node_group_instance_types" {
  description = "(Optional) Set of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set."
  default     = []
}


variable "eks_node_group_release_version" {
  description = "(Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
  default     = null
}

variable "eks_node_group_version" {
  description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  default     = null
}



#---------------------------------------------------
# commantags variable
#---------------------------------------------------

variable "application" {
    type = string   
}
variable "name" {
    type = string
    
}
variable "enviroment" {
    type = string
}
variable "support" {
    type = string


}
variable "creater" {
    type = string
}


#---------------------------------------------------
# Iam roles variable
#---------------------------------------------------

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null 
}

variable "create_eks_service_role" {
  description = "It will define if the iam role will create or not"
  type = bool
  default = true
  
}

#---------------------------------------------------------
# Farget variable 
#_____________________________________________________

variable "fargate_subnet" {
  description = "subnets of fargate"
}

#---------------------------------------------------
# Oidc variable
#---------------------------------------------------
variable "client_id" {
  description = "(Required) Client ID for the OpenID Connect identity provider."
  default = " "
  type = string
  
}

variable "identity_provider_config_name" {
  description = "(Required) The name of the identity provider config."
  default = " "
  type = string
  
}

variable "bucket_name" {
  description = "S3 bucket name for backend"
  default = " "
  type = string