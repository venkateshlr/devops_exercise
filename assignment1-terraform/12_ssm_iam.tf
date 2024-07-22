resource "aws_iam_role" "ssm_role" {
  name = "ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "ssm_instance" {
  ami                         = "ami-0c55b159cbfafe1f0" # Replace with your AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_az1.id
  associate_public_ip_address = true
  key_name                    = "my-key" # Replace with your key pair

  iam_instance_profile = {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  tags = {
    Name = "ssm-instance"
  }
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}
