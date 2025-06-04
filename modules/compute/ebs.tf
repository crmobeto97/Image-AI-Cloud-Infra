resource "aws_ebs_volume" "volume_1" {
  availability_zone = var.availability_zones[1]
  size              = var.volume_size_1
  type              = "gp3"
  tags = merge(
    {
      Name = "${var.resource_prefix}-volume-1"
    },
    var.tags
  )
}