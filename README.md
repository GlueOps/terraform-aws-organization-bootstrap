# terraform-aws-organization-bootstrap


This Terraform module helps you bootstrap your Organization in AWS with a set of core accounts and an IAM role enabling cross-account access to the child accounts.

Example usage:

```hcl

locals {
  account_metadata = {
    "admiral": "admiral@antoniostacos.net",
    "captain": "captain@antoniostacos.net"   
  }
}


module "organization_bootstrap" {
  source                   = "github.com/GlueOps/terraform-aws-organization-bootstrap.git"
  account_metadata         = local.account_metadata
}
```

## Inputs Required:

| Name | Description | Required |
| --- | ----------- | -------- |
| account_metadata | Map of your desired aws account name : email address for your account. | Yes |
| aws_service_access_principals | Principals to receive access in child accounts. | No |
| organization_access_role_name | Role name to allow access into child accounts. | No |
| organization_root_policy | The policy the org access role recieves in child accounts. | No |

