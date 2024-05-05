resource "aws_db_instance" "example_db" {
  engine                 = "mysql"
  db_name                = "dbtest"
  identifier             = "dbtest"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = true #Public DB
  username               = var.db-username
  password               = var.db-password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  #Disable taking a final backup when you destroy the database as it is a test env
  skip_final_snapshot    = true 

  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  tags = {
    Name = "example-db"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "my-db-subnet-group"
  subnet_ids = [aws_subnet.sub_public_a.id, aws_subnet.sub_public_b.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "db_sg_"

  vpc_id = aws_vpc.my_vpc.id

  # Add any additional ingress/egress rules as needed
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}