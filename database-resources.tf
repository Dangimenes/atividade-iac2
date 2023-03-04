resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg"
  description = "Security group for RDS database"
  vpc_id     = aws_vpc.vpc_aula_iac.id  

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.subnet_aula_iac_1a.id,aws_subnet.subnet_aula_iac_1b.id,aws_subnet.subnet_aula_iac_1c.id]

  tags = {
    Name = "tag atividade iac subnet group for db"
  }
}

resource "aws_db_instance" "rds_db" {
  identifier            = "my-rds-db"
  engine                = "postgres"
  engine_version        = "13.4"
  instance_class        = "db.t3.micro"
  name                  = "my_rds_database"
  username              = "test"
  password              = "COnn&ect%2023"
  parameter_group_name  = "default.postgres13"
  skip_final_snapshot   = true
  publicly_accessible   = false
  allocated_storage     = 20
  storage_type          = "gp2"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}
