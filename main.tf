provider "aws" {
  region = var.region
}

locals {
  resolved_environment    = lookup(var.environment_names, terraform.workspace, "unknown")

  tags                    = merge({
    environment             = local.resolved_environment
  }, var.static_tags)
  
  resource_prefix         = "${var.static_tags["application"]}-${terraform.workspace}"
  user_data                = templatefile("${path.module}/tf_templates/userdata.sh", {})
  
}

module "network" {
  source                             = "./modules/network"
  region                             = var.region
  resource_prefix                    = local.resource_prefix
  tags                               = local.tags
  vpc_cidr_block                     = var.vpc_cidr_block
  instance_tenancy                   = var.instance_tenancy
  enable_dns_support                 = var.enable_dns_support
  enable_dns_hostnames               = var.enable_dns_hostnames
  domain                             = var.domain
  create_nat_gateway                 = var.create_nat_gateway
  destination_cidr_block             = var.destination_cidr_block
  map_public_ip_on_launch            = var.map_public_ip_on_launch
  public_subnet_cidr_blocks          = var.public_subnet_cidr_blocks
  db_subnet_cidr_blocks              = var.db_subnet_cidr_blocks
  availability_zones                 = var.availability_zones
  create_s3_endpoint                 = var.create_s3_endpoint
  create_secrets_manager_endpoint    = var.create_secrets_manager_endpoint
  create_cloudwatch_logs_endpoint    = var.create_cloudwatch_logs_endpoint
  ingress_public_nacl_rule_no        = var.ingress_public_nacl_rule_no
  ingress_public_nacl_action         = var.ingress_public_nacl_action
  ingress_public_nacl_from_port      = var.ingress_public_nacl_from_port
  ingress_public_nacl_to_port        = var.ingress_public_nacl_to_port
  ingress_public_nacl_protocol       = var.ingress_public_nacl_protocol
  ingress_public_nacl_cidr_block     = var.ingress_public_nacl_cidr_block
  egress_public_nacl_rule_no         = var.egress_public_nacl_rule_no
  egress_public_nacl_action          = var.egress_public_nacl_action
  egress_public_nacl_from_port       = var.egress_public_nacl_from_port
  egress_public_nacl_to_port         = var.egress_public_nacl_to_port
  egress_public_nacl_protocol        = var.egress_public_nacl_protocol
  egress_public_nacl_cidr_block      = var.egress_public_nacl_cidr_block
  ingress_db_nacl_rule_no            = var.ingress_db_nacl_rule_no
  ingress_db_nacl_action             = var.ingress_db_nacl_action
  ingress_db_nacl_from_port          = var.ingress_db_nacl_from_port
  ingress_db_nacl_to_port            = var.ingress_db_nacl_to_port
  ingress_db_nacl_protocol           = var.ingress_db_nacl_protocol
  ingress_db_nacl_cidr_block         = var.ingress_db_nacl_cidr_block
  egress_db_nacl_rule_no             = var.egress_db_nacl_rule_no
  egress_db_nacl_action              = var.egress_db_nacl_action
  egress_db_nacl_from_port           = var.egress_db_nacl_from_port
  egress_db_nacl_to_port             = var.egress_db_nacl_to_port
  egress_db_nacl_protocol            = var.egress_db_nacl_protocol
  egress_db_nacl_cidr_block          = var.egress_db_nacl_cidr_block
}

module "compute" {
  source                             = "./modules/compute"
  region                             = var.region
  availability_zones                 = var.availability_zones
  resource_prefix                    = local.resource_prefix
  tags                               = local.tags
  instance_type                      = var.instance_type
  iam_instance_profile               = var.iam_instance_profile
  key_name                           = var.key_name
  private_ip                         = var.private_ip
  public_subnet_ids                  = module.network.public_subnet_ids
  security_groups_ids                = module.network.security_groups_ids
  user_data                          = local.user_data
  volume_size_1                      = var.volume_size_1
}