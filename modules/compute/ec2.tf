data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "insatnces_1" {
  ami                       = data.aws_ami.ubuntu.id
  instance_type             = var.instance_type
  iam_instance_profile      = var.iam_instance_profile
  key_name                  = var.key_name
  
  root_block_device {
    volume_size = var.volume_size_1
    volume_type = "gp3"
    tags = merge(
        {
          Name = "${var.resource_prefix}-root-volume-1"
        },
        var.tags
    )
  }
  
  ## Network ##
  #availability_zone    = var.availability_zones[1]
  private_ip               = var.private_ip
  subnet_id                = element(var.public_subnet_ids, 0) # Example, select first subnet
  vpc_security_group_ids   = var.security_groups_ids
  
  # Internal config ##
  user_data                = var.user_data
  
  tags = merge(
    {
      Name = "${var.resource_prefix}-1"
    },
    var.tags
  )
  
}