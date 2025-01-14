resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = "two-tier-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.main.id
tags = {
  Name = "two-tier-igw"
}
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = element(data.aws_availability_zones.available.names, count.index)

    tags = {
        Name = "public-subnet-${count.index + 1}"
        Tier  = "public"
    }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
    Tier = "private"
  }
}

data "aws_availability_zones" "available" {}


resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
