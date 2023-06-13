resource "aws_s3_bucket_object" "folder1" {
  count  = var.add_folder ? length(var.folders) : 0
  bucket = var.existing_bucket == "" ? join(",", aws_s3_bucket.s3.*.id) : var.existing_bucket
  acl    = var.bucket_acl
  key    = "${var.folder_path}/${element(var.folders, count.index)}/"
  source = "/dev/null"

  tags = {
    Name         = var.bucket_name
    Project      = var.project_name
    Environment  = var.environment_name
    Terraform    = "true"
    BusinessUnit = var.tag_BusinessUnit
    Creator      = var.tag_Creator
    Stack        = var.tag_Stack
    TechTeam     = var.tag_TechTeam
    JIRA         = var.tag_JiraId
  }
}

