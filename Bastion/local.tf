locals {
  common_tags = {
    Project     = var.Project_name
    Environment = var.Environment
  }
  common_name     = "${var.Project_name}-${var.Environment}"
  az              = split(",", data.aws_ssm_parameter.public.value)[0]
  sg_id           = data.aws_ssm_parameter.bastion_sg.value
  mongo_sg_id     = data.aws_ssm_parameter.mongo_sg.value
  mongo_subnet_id = split(",", data.aws_ssm_parameter.database.value)[0]

}