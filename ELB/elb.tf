resource "aws_lb" "app" {
  name               = "${local.common_name}-elb"
  internal           = var.elb_internal
  load_balancer_type = var.elb_type
  security_groups    = [local.sg]
  subnets            = local.subnet_ids

  tags = merge(
    var.elb_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-elb"
    }
  )
}


resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello from ${var.Project_name}-${var.Environment} ELB"
      status_code  = "200"
    }
  }
}

resource "aws_lb" "backend" {
  name = "${local.common_name}-backend-elb"
  internal            = var.elb_internal
  load_balancer_type  = var.elb_type
  subnets             = local.backend_subnet_ids
  security_groups     = [local.backend_elb_sg]

  tags = merge(
    var.elb_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-backend-elb"
    }
  )
}


resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello from ${var.Project_name}-${var.Environment}-Backend ELB"
      status_code  = "200"
    }
  }
}