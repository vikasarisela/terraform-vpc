resource "aws_vpc_peering_connection" "default"{
  count = var.is_peering_required ? 1: 0 
  peer_vpc_id   = data.aws_vpc.default.id  # acceptor
  vpc_id        = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  auto_accept   = true
   tags = merge(
    var.peering_tags,
    local.common_tags,
    {
        Name =  "${local.common_name_suffix}-default"
    }
  )
}

resource "aws_route" "main_to_default" {
  count = var.is_peering_required ? 1 : 0 
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block# CIDR of the Accepter VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "default_to_main" {
  count = var.is_peering_required ? 1 : 0 
  route_table_id            = data.aws_vpc.default.main_route_table_id
  destination_cidr_block    = var.cidr_block# CIDR of the Accepter VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

