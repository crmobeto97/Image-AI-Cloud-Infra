# Common Variables

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}

variable "region" {
  type        = string
  description = "Region of the VPC"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones"
}

variable "resource_prefix" {
  description = "Prefix used to name resources according to the selected workspace"
  type        = string
}

### EC2 ####

#### EBS Variables ####

variable "volume_size_1" {
    description = "Storage size for EBS Volume 1 "
    type        = number
}

#### Instances Variables ####

variable "instance_type" {
  description   = "Instances compute type"
  type          = string
}

variable "iam_instance_profile" {
  description   = "instances iam role (instances permisions)"
  type          = string
}

variable "key_name" {
  description   = "The Key Pair for ssh Instanaces access"
  type          = string
}

variable "private_ip" {
  description   = "private ip"
  type          = string
}

variable "public_subnet_ids" {
 type           = list(string)
 description    = "IDs of the subnets"
}

variable "user_data" {
  description   = "command run ec2 when 1st start"
}