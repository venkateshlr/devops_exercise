resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]
  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_instance" "mariadb_replica" {
  identifier              = "mariadb-replica"
  allocated_storage       = 20
  engine                  = "mariadb"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  username                = "admin"
  password                = "password"
  subnet_group_name       = aws_db_subnet_group.db_subnet_group.name
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  replication_source_identifier = aws_db_instance.mariadb_master.arn

  tags = {
    Name = "mariadb-replica"
  }
}

resource "aws_db_instance" "mariadb_master" {
  identifier              = "mariadb-master"
  allocated_storage       = 20
  engine                  = "mariadb"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  username                = "admin"
  password                = "password"
  subnet_group_name       = aws_db_subnet_group.db_subnet_group.name
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "mariadb-master"
  }
}
