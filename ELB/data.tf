data "aws_ssm_parameter" "public" {
  name = "/${local.common_name}/subnets/public"
  }

  data "aws_ssm_parameter" "frontend_elb_sg" {
    name = "/${local.common_name}/sg/frontend-elb"
  }

  data "aws_ssm_parameter" "backend_elb_sg" {
    name = "/${local.common_name}/sg/backend-elb"
  }

data "aws_ssm_parameter" "private" {
    name = "/${local.common_name}/subnets/private"
  }