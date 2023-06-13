variable "email" {
  default = ""
}

variable "environment_name" {
  default = ""
}

variable "tag_BusinessUnit" {
  default = ""
}

variable "tag_Creator" {
  default = ""
}

variable "tag_Stack" {
  default = ""
}

variable "tag_TechTeam" {
  default = ""
}

variable "tag_JiraId" {
  default = ""
}

variable "force_destory" {
  default = false
}

variable "create_user" {
  description = "Whether to create the IAM user"

  #  type        = "bool"
  default = "true"
}

variable "create_iam_user_login_profile" {
  description = "Whether to create IAM user login profile"

  #  type        = "bool"
  default = "true"
}

variable "create_iam_access_key" {
  description = "Whether to create IAM access key"

  #  type        = "bool"
  default = "false"
}

variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."

  #  type        = "bool"
  default = "false"
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key. `pgp_key` is required when `create_iam_user_login_profile` is set to `true`"
  type        = string
  default     = ""
}

variable "password_reset_required" {
  description = "Whether the user should be forced to reset the generated password on first login."

  #  type        = "bool"
  default = "true"
}

variable "password_length" {
  description = "The length of the generated password"

  #  type        = "number"
  default = 12
}

variable "upload_iam_user_ssh_key" {
  description = "Whether to upload a public ssh key to the IAM user"

  #  type        = "bool"
  default = "false"
}

variable "ssh_key_encoding" {
  description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM"
  type        = string
  default     = "SSH"
}

variable "ssh_public_key" {
  description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format"
  type        = string
  default     = ""
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "groups" {
  description = "List of groups command separated"
  type        = string
  default     = ""
}

variable "service_account" {
  description = "service account first.last+project@windli.com"
  type        = string
  default     = "false"
}

variable "inline_policy" {
  description = "Inline policy file should be create with JIRAID.json format in inlinePolicy folder"
  default     = "/"
}

variable "create_inline_policy" {
  description = "Inline policy will be attached if its true"
  default     = "false"
}

