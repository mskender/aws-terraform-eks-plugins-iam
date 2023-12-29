resource "aws_iam_policy" "eks_load_balancer_controller" {
  count  = var.create_aws_lb_ctrl ? 1 : 0
  name   = "${local.prefix}eks-alb-controller"
  policy = file("${path.module}/policies/aws-lb-policy.json")
}


resource "aws_iam_role" "eks_load_balancer_controller" {
  count = var.create_aws_lb_ctrl ? 1 : 0
  name  = "${local.prefix}eks-alb-controller"
  assume_role_policy = templatefile(
    "${path.module}/policies/oidc-assume-role.tpl",
    {
      oidc_arn  = var.oidc_provider_arn,
      oidc_url  = replace(var.eks_oidc_url, "https://", ""),
      namespace = var.aws_lb_ctrl_namespace,
      sa        = var.aws_lb_ctrl_sa
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_load_balancer_controller" {
  count      = var.create_aws_lb_ctrl ? 1 : 0
  role       = aws_iam_role.eks_load_balancer_controller[0].name
  policy_arn = aws_iam_policy.eks_load_balancer_controller[0].arn
}
