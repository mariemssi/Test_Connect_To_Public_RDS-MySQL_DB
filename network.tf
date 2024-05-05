resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true 
  enable_dns_hostnames = true
}

#Create the first private subnet
resource "aws_subnet" "sub_private_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

#Create the second private subnet
resource "aws_subnet" "sub_private_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

#Create the private route table 
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.my_vpc.id
}

#Associate the private route table to the first private subnet
resource "aws_route_table_association" "rt_assoc_private_a" {
  subnet_id      = aws_subnet.sub_private_a.id
  route_table_id = aws_route_table.rt_private.id
}

#Associate the private route table to the second private subnet
resource "aws_route_table_association" "rt_assoc_private_b" {
  subnet_id      = aws_subnet.sub_private_b.id
  route_table_id = aws_route_table.rt_private.id
}

#Add a route to the natgateway to the private route table
#Not required in this use case
resource "aws_route" "route_pa" {
  route_table_id         = aws_route_table.rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
}

#Create an elastic IP to attach to the nat-gateway
#Not required in this use case
resource "aws_eip" "eip" {
}

#Create the nat-gateway in a public subnet
#Not required in this use case
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.sub_public_a.id
  depends_on    = [aws_eip.eip]
}

#Create an internet-gateway and attach to the my_vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

#Create the first publmic subnet
resource "aws_subnet" "sub_public_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}

#Create the second public subnet
resource "aws_subnet" "sub_public_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
}

#Create a public route table
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.my_vpc.id
}

#Associate the public route table to the first public subnet
resource "aws_route_table_association" "rt_assoc_public_a" {
  subnet_id      = aws_subnet.sub_public_a.id
  route_table_id = aws_route_table.rt_public.id
}

#Associate the public route table to the second public subnet
resource "aws_route_table_association" "rt_assoc_public_b" {
  subnet_id      = aws_subnet.sub_public_b.id
  route_table_id = aws_route_table.rt_public.id
}

#Add a route to the internet gateway to the public route table
resource "aws_route" "route_a" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

