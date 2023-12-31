# It would be awesome if we could get the route tables dynamically rather than have to be passed
# them (Which we can!) But unforunately we can't iterate over computed values - so we're
# stuck with this for now. It's being worked on.
resource "aws_route" "peer_src_to_peer_dst" {
  count = var.create_peering_connection ? length(var.peer_src_route_tables) : 0

  provider = aws.src

  route_table_id            = element(var.peer_src_route_tables, count.index)
  destination_cidr_block    = data.aws_vpc.peer_dst_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[0].id
}

resource "aws_route" "peer_dst_to_peer_src" {
  count = var.create_peering_connection && var.dst_in_same_account ? length(var.peer_dst_route_tables) : 0

  provider = aws.dst

  route_table_id            = element(var.peer_dst_route_tables, count.index)
  destination_cidr_block    = data.aws_vpc.peer_src_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[0].id
}

