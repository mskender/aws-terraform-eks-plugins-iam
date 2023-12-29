# EKS Plugins IAM Terraform module


## Description

This is a simple module for creating IAM roles for IRSA OIDC consumption by following EKS plugins:

- AWS EKS Cluster Autoscaler
- Karpenter
- AWS EBS CSI driver
- External-DNS
- AWS LoadBalancer Controller

Stay tuned for more plugins!

## Examples

An example using an eks module to provision a cluster (https://github.com/mskender/aws-terraform-eks):
```
module "k8s" {

  source = "github.com/mskender/aws-terraform-eks.git?ref=v0.2.6"

  create_cluster = true
  enable_oidc    = true
  eks_version    = "1.27"
  region         = local.region
  cluster_name   = local.cluster_name
  eks_subnet_ids = local.private_subnet_ids

}

module "eks-iam-roles" {

  source = "github.com/mskender/aws-terraform-eks-plugins-iam.git"

  create_aws_autoscaler     = false
  create_karpenter          = true
  create_eks_ebs_csi_driver = true
  create_aws_lb_ctrl        = true

  eks_cluster_name  = local.cluster_name
  eks_oidc_url      = module.k8s.cluster_oidc_url
  oidc_provider_arn = module.k8s.oidc_provider_arn

  eks_ebs_csi_driver_namespace = "aws-ebs-csi"

}
```
