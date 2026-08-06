output "frontend_elb" {
    value = nonsensitive(data.aws_ssm_parameter.frontend_elb_sg.value)
}