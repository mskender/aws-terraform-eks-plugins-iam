
resource "aws_iam_policy" "eks_karpenter" {
  count = var.create_karpenter ? 1 : 0
  name  = "${local.prefix}eks-karpenter-${var.eks_cluster_name}"
  policy = templatefile("${path.module}/policies/aws-karpenter-policy.tpl", {
    account_id       = data.aws_caller_identity.current.account_id,
    aws_region       = data.aws_region.current.name,
    cluster_name     = var.eks_cluster_name,
    worker_node_role = var.karpenter_worker_node_role_arn == "" ? aws_iam_role.eks-worker[0].arn : var.karpenter_worker_node_role_arn
  })
}


resource "aws_iam_role" "eks_karpenter" {
  count = var.create_karpenter ? 1 : 0
  name  = "${local.prefix}eks-karpenter-${var.eks_cluster_name}"
  assume_role_policy = templatefile(
    "${path.module}/policies/oidc-assume-role.tpl",
    {
      oidc_arn = var.oidc_provider_arn,
      oidc_url = replace(var.
      eks_oidc_url, "https://", ""),
      lbctrl_namespace = var.karpenter_namespace,
      lbctrl_sa        = var.karpenter_sa
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_karpenter" {
  count      = var.create_karpenter ? 1 : 0
  role       = aws_iam_role.eks_karpenter[0].name
  policy_arn = aws_iam_policy.eks_karpenter[0].arn
}


resource "aws_iam_instance_profile" "eks_karpenter" {
  count = var.create_karpenter ? 1 : 0
  name  = "${local.prefix}eks-karpenter-${var.eks_cluster_name}"
  role  = var.karpenter_worker_node_role_arn == "" ? split("/", aws_iam_role.eks-worker[0].arn)[1] : split("/", var.karpenter_worker_node_role_arn)[1]
}
