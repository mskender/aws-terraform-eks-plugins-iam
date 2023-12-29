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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.eks-worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.eks_karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.eks_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks-worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker-AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_autoscaler_namespace"></a> [aws\_autoscaler\_namespace](#input\_aws\_autoscaler\_namespace) | Namespace for AWS LB Controller. | `string` | `"kube-system"` | no |
| <a name="input_aws_autoscaler_sa"></a> [aws\_autoscaler\_sa](#input\_aws\_autoscaler\_sa) | Service account for AWS LB Controller. | `string` | `"cluster-autoscaler"` | no |
| <a name="input_aws_lb_ctrl_namespace"></a> [aws\_lb\_ctrl\_namespace](#input\_aws\_lb\_ctrl\_namespace) | Namespace for AWS LB Controller. | `string` | `"kube-system"` | no |
| <a name="input_aws_lb_ctrl_sa"></a> [aws\_lb\_ctrl\_sa](#input\_aws\_lb\_ctrl\_sa) | Service account for AWS LB Controller. | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_create_aws_autoscaler"></a> [create\_aws\_autoscaler](#input\_create\_aws\_autoscaler) | Whether to create AWS Cluster Autoscaler IAM role. | `bool` | `true` | no |
| <a name="input_create_aws_lb_ctrl"></a> [create\_aws\_lb\_ctrl](#input\_create\_aws\_lb\_ctrl) | Whether to create AWS LoadBalancer Controller IAM role | `bool` | `true` | no |
| <a name="input_create_eks_ebs_csi_driver"></a> [create\_eks\_ebs\_csi\_driver](#input\_create\_eks\_ebs\_csi\_driver) | Whether to create AWS EBS CSI driver IAM role. | `bool` | `true` | no |
| <a name="input_create_external_dns"></a> [create\_external\_dns](#input\_create\_external\_dns) | Whether to create External DNS IAM role. | `bool` | `true` | no |
| <a name="input_create_karpenter"></a> [create\_karpenter](#input\_create\_karpenter) | Whether to create AWS Karpenter IAM role. | `bool` | `true` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_ebs_csi_driver_namespace"></a> [eks\_ebs\_csi\_driver\_namespace](#input\_eks\_ebs\_csi\_driver\_namespace) | Namespace for AWS LB Controller. | `string` | `"kube-system"` | no |
| <a name="input_eks_ebs_csi_driver_sa"></a> [eks\_ebs\_csi\_driver\_sa](#input\_eks\_ebs\_csi\_driver\_sa) | Service account for AWS LB Controller. | `string` | `"ebs-csi-controller-sa"` | no |
| <a name="input_eks_oidc_url"></a> [eks\_oidc\_url](#input\_eks\_oidc\_url) | Cluster OIDC identifier. Mandatory. | `string` | n/a | yes |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | Default namespace for External DNS plugin. Defaults to external-dns. | `string` | `"external-dns"` | no |
| <a name="input_external_dns_sa"></a> [external\_dns\_sa](#input\_external\_dns\_sa) | Default SA of External DNS plugin. Defaults to external-dns. | `string` | `"external-dns"` | no |
| <a name="input_external_dns_zone_list"></a> [external\_dns\_zone\_list](#input\_external\_dns\_zone\_list) | Zones to allow External Secrets plugin to manage. Defaults to '*' | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_karpenter_namespace"></a> [karpenter\_namespace](#input\_karpenter\_namespace) | Namespace for Karpenter. | `string` | `"karpenter"` | no |
| <a name="input_karpenter_sa"></a> [karpenter\_sa](#input\_karpenter\_sa) | Service account for Karpenter. | `string` | `"karpenter"` | no |
| <a name="input_karpenter_worker_iam_role_name"></a> [karpenter\_worker\_iam\_role\_name](#input\_karpenter\_worker\_iam\_role\_name) | Name of worker role to be created if `karpenter_worker_node_role_arn` is not provided. Defaults to `{var.prefix}-{var.eks_cluster_name}-worker-group`. | `string` | `""` | no |
| <a name="input_karpenter_worker_node_role_arn"></a> [karpenter\_worker\_node\_role\_arn](#input\_karpenter\_worker\_node\_role\_arn) | The Arn of role that worker nodes usually assume. Required for Karpenter only. Will be created if not specified. | `string` | `""` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC provider ARN identifier. Mandatory. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix names of all resources created. | `string` | `""` | no |

## Outputs

No outputs.
