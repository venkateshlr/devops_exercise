resource "aws_launch_configuration" "ec2_launch_config" {
  name          = "ec2-launch-configuration"
  image_id      = "ami-0c55b159cbfafe1f0" # Replace with your AMI ID
  instance_type = "t2.micro"
  associate_public_ip_address = false
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup python -m SimpleHTTPServer 80 &
              EOF

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = 8
  }

  security_groups = [aws_security_group.instance.id]

  tags = {
    Name = "ec2-launch-configuration"
  }
}

resource "aws_autoscaling_group" "ec2_asg" {
  launch_configuration = aws_launch_configuration.ec2_launch_config.id
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.private_subnet_az2.id]

  tag {
    key                 = "Name"
    value               = "EC2-AutoScaling-Group"
    propagate_at_launch = true
  }
}
