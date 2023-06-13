resource "aws_iam_user" "this" {
  count = var.create_user == "true" ? 1 : 0

  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
}

resource "aws_iam_user_login_profile" "this" {
  count = var.create_iam_user_login_profile == "true" ? 1 : 0

  user                    = aws_iam_user.this[0].name
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required
}

resource "aws_iam_access_key" "this" {
  count = var.create_iam_access_key == "true" ? 1 : 0

  user    = aws_iam_user.this[0].name
  pgp_key = var.pgp_key
}

resource "aws_iam_access_key" "this_no_pgp" {
  count = var.pgp_key == "" ? 1 : 0

  user = aws_iam_user.this[0].name
}

resource "aws_iam_user_ssh_key" "this" {
  count = var.upload_iam_user_ssh_key == "true" ? 1 : 0

  username   = aws_iam_user.this[0].name
  encoding   = var.ssh_key_encoding
  public_key = var.ssh_public_key
}

resource "aws_iam_user_group_membership" "this" {
  user = join(",", aws_iam_user.this.*.name)

  groups = [var.groups]

  depends_on = [aws_iam_user.this]
}

/*
resource "aws_iam_user" "that" {
  count = "${var.service_account == "true" ? 1 : 0}"

  name                 = "${var.name}"
  path                 = "${var.path}"
  force_destroy        = "${var.force_destroy}"
  permissions_boundary = "${var.permissions_boundary}"
  tags                 = "${var.tags}"
}

*/

data "template_file" "policy" {
  count    = var.create_inline_policy == "true" ? 1 : 0
  template = file(var.inline_policy)
}

resource "aws_iam_user_policy" "this" {
  count = var.create_inline_policy == "true" ? 1 : 0

  name = var.name
  user = aws_iam_user.this[0].name

  policy = data.template_file.policy[0].rendered
}

