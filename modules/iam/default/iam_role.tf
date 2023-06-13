//Template files for policy
data "template_file" "ec2-assume-role-policy" {
  template = file("${path.module}/policy.ec2-principal.tpl")
}
data "template_file" "eks_access_policy" {
  template = file("${path.module}/policy.jumphost_eks_access.tpl")
}
data "template_file" "role_policy" {
  count = var.create_ec2_role ? 1 : 0
  template = file("${path.module}/policy.${var.role_name}.tpl")

  vars = {
    default_s3_bucket = var.default_s3_bucket
  }
}

//Create instance profile for role to be attached to instance
resource "aws_iam_instance_profile" "instance_profile" {
  count = var.create_ec2_role ? 1 : 0
  name = aws_iam_role.iam_role[count.index].name
  role = aws_iam_role.iam_role[count.index].name
}

resource "aws_iam_instance_profile" "eks_instance_profile" {
  count = var.create_eks_role ? 1 : 0
  name = aws_iam_role.eks_access_role[count.index].name
  role = aws_iam_role.eks_access_role[count.index].name
}

//Create role with assumed policy
resource "aws_iam_role" "iam_role" {
  count = var.create_ec2_role ? 1 : 0
  name               = "${var.role_name}_role"
  assume_role_policy = data.template_file.ec2-assume-role-policy.rendered
  description        = "EC2: IAM role created for instance"
}

resource "aws_iam_role" "eks_access_role" {
  count = var.create_eks_role ? 1 : 0
  name               = "${var.role_name_eks}_role"
  assume_role_policy = data.template_file.ec2-assume-role-policy.rendered
  description        = "EC2: IAM role created to access eks"
}

//Attache inline policy to role
resource "aws_iam_role_policy" "policy" {
  count = var.create_ec2_role ? 1 : 0
  name   = "${var.role_name}_role_policy"
  role   = aws_iam_role.iam_role[count.index].id
  policy = data.template_file.role_policy[count.index].rendered
}

resource "aws_iam_role_policy" "eks_access_policy" {
  count = var.create_eks_role ? 1 : 0
  name   = "${var.role_name_eks}_role_policy"
  role   = aws_iam_role.eks_access_role[count.index].id
  policy = data.template_file.eks_access_policy.rendered
}


###########assume_role###########
resource "aws_iam_role" "assume_role" {
  count = var.create_assume_role ? 1 : 0
  name = "${var.assume_role_name}-role"

  inline_policy {
    name   = "${var.assume_role_name}-inline_policy"
    policy = var.assume_role_inLinePolicy
  }

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = var.assume_role_policy

  tags = {
    name = "${var.assume_role_name}-role"
    Owner = "DevOps"
    CreatedBy =  "Terraform"
  }
}


##########OUTPUT############
output "assume-role-name" {
  value = aws_iam_role.assume_role.*.name
}

output "assume-role-arn" {
  value = aws_iam_role.assume_role.*.arn
}

output "ec2-role-name" {
  value = aws_iam_role.iam_role.*.name
}

output "ec2-role-arn" {
  value = aws_iam_role.iam_role.*.arn
}

output "eks-access-name" {
  value = aws_iam_role.eks_access_role.*.name
}

output "eks-role-arn" {
  value = aws_iam_role.eks_access_role.*.arn
}

