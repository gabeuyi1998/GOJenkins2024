provider "aws" {
  region = "ap-southeast-2"
}

# Data block to fetch existing VPC
data "aws_vpc" "GO_Dev_VPC" {
  id = "vpc-0dfe4361091cc28f3"
}

# Subnets
resource "aws_subnet" "GO_Dev_public1_subnet" {
  vpc_id                  = data.aws_vpc.GO_Dev_VPC.id
  cidr_block              = "12.0.2.0/24"  # Updated to avoid conflicts
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "GO-Dev-public1-subnet"
  }
}

resource "aws_subnet" "GO_Dev_public2_subnet" {
  vpc_id                  = data.aws_vpc.GO_Dev_VPC.id
  cidr_block              = "12.0.3.0/24"  # Updated to avoid conflicts
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "GO-Dev-public2-subnet"
  }
}

# Security Groups
resource "aws_security_group" "GO_SG_Proj1" {
  vpc_id = data.aws_vpc.GO_Dev_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GO-SG-Proj1"
  }
}

# EC2 Instances
resource "aws_instance" "GO_Jenkins_Master_EC2" {
  ami           = "ami-0892a9c01908fafd1"
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.GO_Dev_public2_subnet.id

  vpc_security_group_ids = [
    aws_security_group.GO_SG_Proj1.id,
  ]

  tags = {
    Name = "GO-Jenkins-Master-EC2"
  }
}

resource "aws_instance" "GO_DEV1_EC2" {
  ami           = "ami-0892a9c01908fafd1"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.GO_Dev_public1_subnet.id

  vpc_security_group_ids = [
    aws_security_group.GO_SG_Proj1.id,
  ]

  tags = {
    Name = "GO-DEV1-EC2"
  }
}