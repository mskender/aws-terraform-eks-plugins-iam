variable "prefix" {
  description = "Prefix names of all resources created."
  default     = ""
  type        = string
}

variable "eks_oidc_url" {
  description = "Cluster OIDC identifier. Mandatory."
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN identifier. Mandatory."
  type        = string
}

variable "create_aws_lb_ctrl" {
  description = "Whether to create AWS LoadBalancer Controller IAM role"
  type        = bool
  default     = true
}

variable "aws_lb_ctrl_namespace" {
  description = "Namespace for AWS LB Controller."
  type        = string
  default     = "kube-system"
}

variable "aws_lb_ctrl_sa" {
  description = "Service account for AWS LB Controller."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "create_aws_autoscaler" {
  description = "Whether to create AWS Cluster Autoscaler IAM role."
  type        = bool
  default     = true
}

variable "aws_autoscaler_namespace" {
  description = "Namespace for AWS LB Controller."
  type        = string
  default     = "kube-system"
}

variable "aws_autoscaler_sa" {
  description = "Service account for AWS LB Controller."
  type        = string
  default     = "cluster-autoscaler"
}

variable "create_eks_ebs_csi_driver" {
  description = "Whether to create AWS EBS CSI driver IAM role."
  type        = bool
  default     = true
}

variable "eks_ebs_csi_driver_namespace" {
  description = "Namespace for AWS LB Controller."
  type        = string
  default     = "kube-system"
}

variable "eks_ebs_csi_driver_sa" {
  description = "Service account for AWS LB Controller."
  type        = string
  default     = "ebs-csi-controller-sa"
}

variable "create_karpenter" {
  description = "Whether to create AWS Karpenter IAM role."
  type        = bool
  default     = true
}

variable "karpenter_namespace" {
  description = "Namespace for Karpenter."
  type        = string
  default     = "karpenter"
}

variable "karpenter_sa" {
  description = "Service account for Karpenter."
  type        = string
  default     = "karpenter"
}

variable "karpenter_worker_node_role_arn" {
  description = "The Arn of role that worker nodes usually assume. Required for Karpenter only. Will be created if not specified."
  type        = string
  default     = ""
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "karpenter_worker_iam_role_name" {
  description = "Name of worker role to be created if `karpenter_worker_node_role_arn` is not provided. Defaults to `{var.prefix}-{var.eks_cluster_name}-worker-group`."
  type        = string
  default     = ""
}
