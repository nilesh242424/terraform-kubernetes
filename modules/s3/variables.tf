variable "lifecycle_rules" {
  description = "A configuration of lifecycle rules. Details: http://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html"
  default     = []
}

variable "bucket_name" {
  default = ""
}

variable "bucket_versioning" {
  default = false
}

variable "create_bucket" {
  default = false
}

variable "add_lifecycle" {
  default = false
}

variable "bucket_acl" {
  default = "private"
}

variable "force_destroy" {
  default = "true"
}

variable "existing_bucket" {
  default = ""
}

variable "folder_path" {
  default = ""
}

variable "attach_policy" {
  default = false
}

variable "template" {
}

variable "project_name" {
}

variable "tag_Creator" {
}

variable "tag_Stack" {
}

variable "tag_BusinessUnit" {
}

variable "tag_TechTeam" {
}

variable "environment_name" {
}

variable "tag_JiraId" {
}

variable "add_folder" {
  default = false
}

variable "folders" {
  default = []
}

