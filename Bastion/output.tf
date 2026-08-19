output "aws_subnet_ids" {
  value = nonsensitive(data.aws_ssm_parameter.public.value)
}

output "data" {
  value = nonsensitive(local.az)
}