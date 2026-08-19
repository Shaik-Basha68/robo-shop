resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = local.az
  vpc_security_group_ids = [local.sg_id]

  tags = merge(
    var.instance_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-bastion"
    }
  )
}
