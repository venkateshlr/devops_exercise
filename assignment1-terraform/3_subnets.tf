resource "aws_subnet" "public_subnet_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-west-2a" # Specify your AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-az1"
  }
}

resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "private-subnet-az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-az2"
  }
}

resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.4.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "private-subnet-az2"
  }
}
