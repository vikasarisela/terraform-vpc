data "aws_availability_zones" "available" {
  state = "available"
}

output "az" {
  value = data.aws_availability_zones.available.names
}

#Used for default vpc if you want other custom vpc use filters 


data "aws_vpc" "default" {
  default = true
}

output "default_vpc" {
  value = data.aws_vpc.default.id
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