output "aws_subnet_ids" {
    value = nonsensitive(data.aws_ssm_parameter.private.value)
}

output "data" {
    value = nonsensitive(local.mongo_subnet_id)
}