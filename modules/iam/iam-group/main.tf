resource "aws_iam_group" "group" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_policy_attachment" "force-mfa" {
  group      = aws_iam_group.group.name
  policy_arn = var.force_mfa_policy_arn
}

