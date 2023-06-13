resource "aws_iam_user" "this" {
  count = length(var.names)

  name          = element(var.names, count.index)
  path          = var.path
  force_destroy = var.force_destroy
}

resource "aws_iam_user_login_profile" "this" {
  count = length(var.names)

  user = element(aws_iam_user.this.*.name, count.index)

  # Initial password getting encrypted with pratap's windli public key, but don't bother with PGP...
  # ...decrypt, just go and reset the password from the console as admin.
  pgp_key = "keybase:pratap_windli"
}

resource "aws_iam_user_group_membership" "force-mfa" {
  count = length(var.names)
  user  = element(aws_iam_user.this.*.name, count.index)

  groups = [
    aws_iam_group.force-mfa.name,
  ]
}

resource "aws_iam_group" "force-mfa" {
  name = "force-mfa-tf"
}

resource "aws_iam_policy" "force-mfa" {
  name        = "force-mfa"
  description = "policy forces mfa usage, but allows user to manage their own mfa device"
  policy      = file("${path.module}/force-mfa.json")
}

resource "aws_iam_group_policy_attachment" "force-mfa" {
  group      = aws_iam_group.force-mfa.name
  policy_arn = aws_iam_policy.force-mfa.arn
}

