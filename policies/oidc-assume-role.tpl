{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${oidc_arn}"
            },
            "Action": [
                "sts:AssumeRoleWithWebIdentity"
            ],
            "Condition": {
                "StringEquals": {
                    "${oidc_url}:sub":"system:serviceaccount:${lbctrl_namespace}:${lbctrl_sa}"
                }
            }
        }
    ]
}