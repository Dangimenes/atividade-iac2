resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg"
  vpc_id      = aws_vpc.vpc_aula_iac.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance1" {
  ami           = "ami-0edab8d70528476d3"
  instance_type = "t2.micro"
  key_name = "key-atividade-iac"
  subnet_id     = aws_subnet.subnet_aula_iac_1a.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  tags = {
    Name = "ec2_instance"
  }
}

resource "aws_instance" "ec2_instance2" {
  ami           = "ami-0edab8d70528476d3"
  instance_type = "t2.micro"
  key_name = "key-atividade-iac"
  subnet_id     = aws_subnet.subnet_aula_iac_1b.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  tags = {
    Name = "ec2_instance2"
  }
}


resource "aws_security_group" "sg_load_balancer" {
  name_prefix = "load-balancer-sg"
  vpc_id      = aws_vpc.vpc_aula_iac.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "iac_target_group" {
  name = "atividade-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc_aula_iac.id

  health_check {
    path = "/"
    protocol = "HTTP"
    interval = 30
    timeout = 10
    unhealthy_threshold = 2
    healthy_threshold = 2
  }
}

resource "aws_lb" "load_balancer" {
  name               = "aula-iac-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.subnet_aula_iac_1a.id,
    aws_subnet.subnet_aula_iac_1b.id
  ]  
  security_groups = [aws_security_group.sg_load_balancer.id]
}

resource "aws_lb_target_group_attachment" "attachment_1" {
  target_group_arn = aws_lb_target_group.iac_target_group.arn
  target_id = aws_instance.ec2_instance1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "attachment_2" {
  target_group_arn = aws_lb_target_group.iac_target_group.arn
  target_id = aws_instance.ec2_instance2.id
  port = 80
}

