resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      Name        = "${var.application}-${var.environment}-vpc",
      Environment = var.environment,
      Owner       = var.owner
      Project     = var.project
    },
    var.tags
  )
}