resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.resource_prefix}-public-route-table"
    },
    var.tags
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.resource_prefix}--db-route-table"
    },
    var.tags
  )
}

resource "aws_route" "db" {
  count = var.create_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.db.id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}
