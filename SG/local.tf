locals {
    common_tags = {
        Project     = var.Project_name
        Environment = var.Environment
    }    
    common_name = "${var.Project_name}-${var.Environment}"  
    vpc_id      = data.aws_ssm_parameter.vpc_id.value
}