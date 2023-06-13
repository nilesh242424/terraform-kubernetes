output "user_names" {
  description = "The user names"
  value       = [aws_iam_user.this.*.name]
}

output "user_arns" {
  description = "The ARN assigned by AWS for this user"
  value       = [aws_iam_user.this.*.arn]
}

output "user_ids" {
  description = "The unique ID assigned by AWS"
  value       = [aws_iam_user.this.*.unique_id]
}

