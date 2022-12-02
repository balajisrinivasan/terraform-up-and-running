resource "aws_launch_configuration" "example" {
  image_id        = "ami-0149b2da6ceec4bb0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg_example.id]
  depends_on = [
    aws_security_group.sg_example
  ]

  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    db_address  = var.db_address
    db_port     = var.db_port
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.mypvc_subnets.ids

  target_group_arns = [aws_lb_target_group.example.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 4

  tag {
    key                 = "Name"
    value               = "terraform-example"
    propagate_at_launch = true
  }
}