resource "aws_iam_role" "eks-worker" {

  count = var.karpenter_worker_node_role_arn == "" ? 1 : 0
  name  = local.eks_worker_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  #permissions_boundary  = var.permissions_boundary
  force_detach_policies = true

}

resource "aws_iam_role_policy_attachment" "worker-AmazonEKSWorkerNodePolicy" {

  count      = var.karpenter_worker_node_role_arn == "" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-worker[0].name
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEKS_CNI_Policy" {

  count      = var.karpenter_worker_node_role_arn == "" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-worker[0].name
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEC2ContainerRegistryReadOnly" {

  count      = var.karpenter_worker_node_role_arn == "" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-worker[0].name
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEBSCSIDriverPolicy" {

  count      = (var.karpenter_worker_node_role_arn == "" && var.create_eks_ebs_csi_driver) ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks-worker[0].name
}

resource "aws_iam_instance_profile" "eks-worker" {

  count = var.karpenter_worker_node_role_arn == "" ? 1 : 0
  name  = local.eks_worker_iam_role_name
  role  = aws_iam_role.eks-worker[0].name
}
