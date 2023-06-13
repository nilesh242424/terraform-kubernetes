variable "role_name" {
    default = ""
}

variable "default_s3_bucket" {
    default = ""
}

variable "role_name_eks" {
    default = ""
}

variable "assume_role_name" {
    default = ""
}

variable "assume_role_inLinePolicy" {
    default = ""
}

variable "assume_role_policy" {
    default = ""
}

variable "create_eks_role" {
  type        = bool
  default     = false
}

variable "create_ec2_role" {
  type        = bool
  default     = false
}

variable "create_assume_role" {
  type        = bool
  default     = false
}
