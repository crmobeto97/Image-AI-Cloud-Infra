resource "aws_security_group" "sg_1" {
  name        = "sg_${var.resource_prefix}_1"
  description = "Allow backend and front-end inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = merge(
    {
      Name = "sg-${var.resource_prefix}-1"
    },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_8000_ipv4" {
  security_group_id = aws_security_group.sg_1.id
  cidr_ipv4         = "0.0.0.0/0" #aws_vpc.main.cidr_block
  from_port         = 8000
  ip_protocol       = "tcp"
  to_port           = 8000
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_3000_ipv4" {
  security_group_id = aws_security_group.sg_1.id
  cidr_ipv4         = "0.0.0.0/0" #aws_vpc.main.cidr_block
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.sg_1.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}