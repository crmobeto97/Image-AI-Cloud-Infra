resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.environment}--internet-gateway",
      Environment = var.environment,
      Owner       = var.owner
    },
    var.tags
  )
}
