resource "aws_security_group_rule" "bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = local.bastion_sg
    description              = "Allow SSH access from anywhere"
}

resource "aws_security_group_rule" "forntend" {
  type                        = "ingress"
  from_port                   = 22
  to_port                     = 22
  protocol                    = "tcp"
  source_security_group_id    = local.bastion_sg
  security_group_id           = local.frontend_sg
    description               = "Allow SSH access from bastion"
}


resource "aws_security_group_rule" "frontend_frontendelb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = local.frontend_elb_sg
  security_group_id        = local.frontend_sg
    description              = "Allow  traffic from elb"
}

resource "aws_security_group_rule" "frontend_elb_public" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = local.frontend_elb_sg
  description              = "Allow incoming traffic from any where"
}

resource "aws_security_group_rule" "backend_elb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
source_security_group_id  = local.bastion_sg
  security_group_id        = local.backend_elb_sg
  description              = "Allow incoming traffic from backend elb"  
}

resource "aws_security_group_rule" "backend_elb_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = local.frontend_sg
  security_group_id        = local.backend_elb_sg
  description              = "Allow incoming traffic from frontend"
}

resource "aws_security_group_rule" "bastion_mongo" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = local.bastion_sg
  security_group_id        = local.mongo_sg
  description              = "Allow incoming traffic from bastion to mongo"
}
