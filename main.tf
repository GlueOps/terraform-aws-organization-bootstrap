data "aws_caller_identity" "current" {}


resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_service_access_principals

  feature_set = "ALL"
}

module "organization_access_role" {
  source = "git::https://github.com/glueops/terraform-aws-organization-access-role.git?ref=1.0.0"

  master_account_id = aws_organizations_organization.org.master_account_id
  role_name         = var.organization_access_role_name
  policy_arn        = var.organization_root_policy
}

resource "aws_organizations_account" "sub_account" {
  for_each = var.account_metadata

  name              = each.key
  email             = each.value
  close_on_deletion = true
  role_name         = var.organization_access_role_name
  depends_on = [
    aws_organizations_organization.org,
    module.organization_access_role
  ]
}
