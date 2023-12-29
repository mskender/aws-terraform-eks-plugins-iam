resource "aws_iam_policy" "eks_external_dns" {
  count = var.create_external_dns ? 1 : 0
  name  = "${local.prefix}eks-external-dns"
  policy = templatefile("${path.module}/policies/aws-eks-external-dns.tpl", {
    zone_list = var.external_dns_zone_list
  })
}


resource "aws_iam_role" "eks_external_dns" {
  count = var.create_external_dns ? 1 : 0
  name  = "${local.prefix}eks-external-dns"
  assume_role_policy = templatefile(
    "${path.module}/policies/oidc-assume-role.tpl",
    {
      oidc_arn  = var.oidc_provider_arn,
      oidc_url  = replace(var.eks_oidc_url, "https://", ""),
      namespace = var.external_dns_namespace
      sa        = var.external_dns_sa
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_external_dns" {
  count      = var.create_external_dns ? 1 : 0
  role       = aws_iam_role.eks_external_dns[0].name
  policy_arn = aws_iam_policy.eks_external_dns[0].arn
}
