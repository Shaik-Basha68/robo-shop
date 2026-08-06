resource "aws_ssm_parameter" "sg_id" {
    count = length(var.sg_name)
    name = "/${local.common_name}/sg/${var.sg_name[count.index]}" #robo-shop-dev-sg-mongo
    type = "String"
    value = aws_security_group.roboshop_sg[count.index].id
}