resource "aws_lb_target_group" "target-group" {
  name     = "tf-alb-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_lb" "alb" {
  name               = "tf-alb-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-server.id]
  subnets            = data.aws_subnet_ids.subnet.ids

  enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.bucket
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "test"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}

# # attach tg to lb
# resource "aws_lb_target_group_attachment" "ec2_attach" {
#   target_group_arn = aws_lb_target_group.target-group.arn
# #   target_id = 
# }