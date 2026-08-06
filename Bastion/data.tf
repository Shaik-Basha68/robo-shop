data "aws_ssm_parameter" "public" {
  name = "/${local.common_name}/subnets/public"
  }

  data "aws_ssm_parameter" "bastion_sg" {
    name = "/${local.common_name}/sg/bastion"
  }



  data "aws_ssm_parameter" "database" {
    name = "/${local.common_name}/subnets/database"
  }

  data "aws_ssm_parameter" "mongo_sg" {
    name = "/${local.common_name}/sg/mongodb"
  }