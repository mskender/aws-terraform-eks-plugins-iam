resource "aws_iam_policy" "eks_autoscaler" {
  count  = var.create_aws_autoscaler ? 1 : 0
  name   = "${local.prefix}eks-autoscaler"
  policy = file("${path.module}/policies/aws-lb-policy.json")
}


resource "aws_iam_role" "eks_autoscaler" {
  count = var.create_aws_autoscaler ? 1 : 0
  name  = "${local.prefix}eks-autoscaler"
  assume_role_policy = templatefile(
    "${path.module}/policies/oidc-assume-role.tpl",
    {
      oidc_arn  = var.oidc_provider_arn,
      oidc_url  = replace(var.eks_oidc_url, "https://", ""),
      namespace = var.aws_autoscaler_namespace,
      sa        = var.aws_autoscaler_sa
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_autoscaler" {
  count      = var.create_aws_autoscaler ? 1 : 0
  role       = aws_iam_role.eks_autoscaler[0].name
  policy_arn = aws_iam_policy.eks_autoscaler[0].arn
}
