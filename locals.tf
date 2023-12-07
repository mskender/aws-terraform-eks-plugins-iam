locals {

  prefix                   = var.prefix == "" ? "" : "${var.prefix}-"
  eks_worker_iam_role_name = var.karpenter_worker_iam_role_name == "" ? "${local.prefix}-${var.eks_cluster_name}-worker-group" : var.karpenter_worker_iam_role_name
}
