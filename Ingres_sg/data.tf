data "aws_ssm_parameter" "bastion_sg" {
  name = "/${local.common_name}/sg/bastion"
}

data "aws_ssm_parameter" "frontend_sg"{
    name ="/${local.common_name}/sg/frontend"
}

data "aws_ssm_parameter" "frontend_elb_sg" {
    name = "/${local.common_name}/sg/frontend-elb"
}

data "aws_ssm_parameter" "backend_elb_sg" {
    name = "/${local.common_name}/sg/backend-elb"
}

data "aws_ssm_parameter" "mongo_sg" {
    name = "/${local.common_name}/sg/mongodb"
}
