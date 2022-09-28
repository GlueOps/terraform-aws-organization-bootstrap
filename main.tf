data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "org" {}


resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_service_access_principals

  feature_set = "ALL"
}

module "organization_access_role" {
  source = "git::https://github.com/glueops/terraform-aws-organization-access-role.git?ref=master"

  master_account_id = data.aws_caller_identity.current.account_id
  role_name         = var.organization_access_role_name
  policy_arn        = var.organization_root_policy
}

resource "aws_organizations_account" "sub_account" {
  for_each = var.account_metadata

  name              = each.key
  email             = each.value
  close_on_deletion = true
  role_name         = var.organization_access_role_name
}