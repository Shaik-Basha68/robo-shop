locals {
    common_tags = {
        Project     = var.Project_name
        Environment = var.Environment
    }
    common_name = "${var.Project_name}-${var.Environment}"
    subnet_ids = split(",", data.aws_ssm_parameter.public.value)
    sg = data.aws_ssm_parameter.frontend_elb_sg.value
    backend_elb_sg = data.aws_ssm_parameter.backend_elb_sg.value
    backend_subnet_ids = split(",", data.aws_ssm_parameter.private.value)
}