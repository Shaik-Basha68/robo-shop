output "aws_vpc_id" {
  value = aws_vpc.main.id
}

# output "public_subnet_ids" {
#   value = aws_subnet.public.*.id
# }
# output "private_subnet_ids" {
#   value = aws_subnet.private.*.id
# }
# output "database_subnet_ids" {
#   value = aws_subnet.database.*.id
#}
output "aws_vpc" {
    value = aws_vpc.main
}

output "aws_availability_zones" {
    value = data.aws_availability_zones.available.names
}

output "aws_availability_zones_count" {
    value = local.azs
}

output "aws_public_subnet_ids" {
    value = aws_subnet.public.*.id
}
output "aws_private_subnet_ids" {
    value = aws_subnet.private.*.id
}
output "aws_database_subnet_ids" {
    value = aws_subnet.database.*.id
}