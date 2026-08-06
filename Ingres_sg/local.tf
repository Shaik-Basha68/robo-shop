locals {
    common_tags = {
        Project     = var.Project_name
        Environment = var.Environment
    }
    common_name = "${var.Project_name}-${var.Environment}"
    bastion_sg      =  data.aws_ssm_parameter.bastion_sg.value
    frontend_elb_sg =  data.aws_ssm_parameter.frontend_elb_sg.value
    frontend_sg     =  data.aws_ssm_parameter.frontend_sg.value 
    backend_elb_sg  =  data.aws_ssm_parameter.backend_elb_sg.value
    mongo_sg        =  data.aws_ssm_parameter.mongo_sg.value
}