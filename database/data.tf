  data "aws_ssm_parameter" "database" {
    name = "/${local.common_name}/subnets/database"
  }

  data "aws_ssm_parameter" "mongo_sg" {
    name = "/${local.common_name}/sg/mongodb"
  }