resource "aws_security_group" "roboshop_sg" {
    count       = length(var.sg_name)
    name        = var.sg_name[count.index]
    vpc_id      = local.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
    var.sg_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-${var.sg_name[count.index]}"
    }
  )
}