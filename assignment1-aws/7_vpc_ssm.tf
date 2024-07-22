resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.ssm"
  tags = {
    Name = "ssm-endpoint"
  }
}
