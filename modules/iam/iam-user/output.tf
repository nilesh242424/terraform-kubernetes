output "this_iam_user_name" {
  description = "The user's name"
  value       = aws_iam_user.this.*.name
}

output "this_iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.this.*.arn
}

output "this_iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.this.*.unique_id
}

output "this_iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = aws_iam_user_login_profile.this.*.encrypted_password
}

output "this_iam_access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.this.*.id
}

output "this_iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = aws_iam_access_key.this.*.encrypted_secret
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = var.pgp_key
}

