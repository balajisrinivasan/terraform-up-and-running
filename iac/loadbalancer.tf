data "aws_subnets" "mypvc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.myvpc_id]
  }
}

resource "aws_lb" "lb_example" {
  name               = "terraform-asg-example"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.mypvc_subnets.ids
  security_groups    = [aws_security_group.sg_alb_example.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb_example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener_rule" "lb_listner_rule_example" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_example.arn
  }
}

resource "aws_lb_target_group" "tg_example" {
  name     = "terraform-target-group-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = var.myvpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = 200
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}