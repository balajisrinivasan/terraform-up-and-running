resource "aws_launch_configuration" "lc_example" {
  image_id        = "ami-0149b2da6ceec4bb0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg_example.id]
  depends_on = [
    aws_security_group.sg_example
  ]

  user_data = <<-EOF
                #!bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port}
                EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_example" {
  launch_configuration = aws_launch_configuration.lc_example.name
  vpc_zone_identifier  = data.aws_subnets.mypvc_subnets.ids

  target_group_arns = [aws_lb_target_group.tg_example.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 4

  tag {
    key                 = "Name"
    value               = "terraform-example"
    propagate_at_launch = true
  }
}