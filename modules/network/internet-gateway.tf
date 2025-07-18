resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.resource_prefix}-internet-gateway"
    },
    var.tags
  )
}
