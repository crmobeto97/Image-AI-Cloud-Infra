resource "aws_eip" "main" {
  count = var.create_nat_gateway ? 1 : 0
  domain = var.domain
}

resource "aws_nat_gateway" "main" {
  count = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.main[0].id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.main]

  tags = merge(
    {
      Name        = "${var.resource_prefix}-nat-gateway"
    },
    var.tags
  )
}