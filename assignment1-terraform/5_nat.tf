resource "aws_eip" "nat_eip_az1" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id
  tags = {
    Name = "nat-gw-az1"
  }
}

resource "aws_eip" "nat_eip_az2" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id
  tags = {
    Name = "nat-gw-az2"
  }
}
