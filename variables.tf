variable "account_metadata" {
  descrption = "Names and email addresses of child accounts to be created within the organization"
  type       = map(any)
}

variable "aws_service_access_principals" {
  description = "Principals to be granted access to the child accounts"
  type        = list(any)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]
}

variable "organization_access_role_name" {
  description = "Role name for roles created within child account to allow access from users in the root account."
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "organization_root_policy" {
  description = "Policy in the root account to be assigned to the org access role enabling permissions within the root account."
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
