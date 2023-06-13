data "template_file" "s3_bucket_policy" {
  template = file(var.template)
  vars = {
    bucket_name = "${var.project_name}-${var.bucket_name}"
  }
}

resource "aws_s3_bucket_policy" "s3" {
  count  = var.attach_policy ? 1 : 0
  bucket = "${var.project_name}-${var.bucket_name}"
  policy = data.template_file.s3_bucket_policy.rendered
}

