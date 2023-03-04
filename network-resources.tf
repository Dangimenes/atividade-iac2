resource "aws_vpc" "vpc_aula_iac" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_aula_iac_1a" {
  vpc_id     = aws_vpc.vpc_aula_iac.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "subnet_aula_iac_1b" {
  vpc_id     = aws_vpc.vpc_aula_iac.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}

resource "aws_subnet" "subnet_aula_iac_1c" {
  vpc_id     = aws_vpc.vpc_aula_iac.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2c"
}

resource "aws_internet_gateway" "vpc_aula_iac_igw" {
  vpc_id = aws_vpc.vpc_aula_iac.id
  tags = {
    Name = "vpc_aula_iac_igw"
  }
}

#segunda vpc e subnets

resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  provider = aws.eu-central-1
}

# Create the second VPC's subnets
resource "aws_subnet" "subnet2a" {
  vpc_id     = aws_vpc.vpc2.id
  provider = aws.eu-central-1
  cidr_block = "10.1.1.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet2b" {
  vpc_id     = aws_vpc.vpc2.id
  provider = aws.eu-central-1
  cidr_block = "10.1.2.0/24"
  availability_zone = "eu-central-1b"
}

resource "aws_subnet" "subnet2c" {
  vpc_id     = aws_vpc.vpc2.id
  provider = aws.eu-central-1
  cidr_block = "10.1.3.0/24"
  availability_zone = "eu-central-1c"
}
