provider "aws" {
  alias  = "src"
  region = var.peer_src_vpc_region
}

provider "aws" {
  alias  = "dst"
  region = var.peer_dst_vpc_region
}

