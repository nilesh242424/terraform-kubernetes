variable "NAT_Gateway" {
  description = "NAT gateway short name"
}

variable "alarm_actions" {
  type = list(string)
}

variable "nat_cacheclusterid" {
}

