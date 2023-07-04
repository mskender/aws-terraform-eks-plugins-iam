resource "aws_iam_role" "eks_ebs_csi_driver" {
  count = var.create_eks_ebs_csi_driver ? 1:0
  name                 = "${local.prefix}eks-csi-driver"
  assume_role_policy   = templatefile(
                      "${path.module}/policies/oidc-assume-role.tpl",
                      {
                        oidc_arn = var.oidc_provider_arn,
                        oidc_url = replace(var.eks_oidc_url, "https://", ""),
                        lbctrl_namespace = var.eks_ebs_csi_driver_namespace,
                        lbctrl_sa = var.eks_ebs_csi_driver_sa
                      }
                      )
}

resource "aws_iam_role_policy_attachment" "eks_ebs_csi_driver" {
  count = var.create_eks_ebs_csi_driver ? 1:0
  role       = aws_iam_role.eks_ebs_csi_driver[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}