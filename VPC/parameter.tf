resource "aws_ssm_parameter" "vpc_id" {
    name  = "/${local.common_name}/vpc/id"
    type  = "String"
    value = aws_vpc.main.id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
    name  = "/${local.common_name}/subnets/public"
    type  = "StringList"
    value = join(",", aws_subnet.public.*.id)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
    name  = "/${local.common_name}/subnets/private"
    type  = "StringList"
    value = join(",", aws_subnet.private.*.id)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
    name  = "/${local.common_name}/subnets/database"
    type  = "StringList"
    value = join(",", aws_subnet.database.*.id)
}   