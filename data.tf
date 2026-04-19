data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

#cusutom vpc 

# data "aws_vpc" "prod" {
#   filter {
#     name   = "tag:Name"
#     values = ["prod_vpc"]
#   }
# }

# output "vpc_id" {
#   value = data.aws_vpc.prod.id
# }