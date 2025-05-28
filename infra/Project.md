
cd infra/vpc
terraform init
terraform plan  -var-file=../../vars/0-dev/vpc.tfvars

add
"-var-file=../../vars/0-dev/vpc.tfvars"
for the commands



information from https://devopscube.com/terraform-aws-vpc/