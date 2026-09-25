terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


#VPC for Esell
resource "aws_vpc" "esell_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "esell-vpc"
  }
}

#subnet for Esell
resource "aws_subnet" "esell-subnet" {
  vpc_id     = aws_vpc.esell_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Names = "esell-subnet"
  }
}

#subnet-2 for Esell
resource "aws_subnet" "esell-subnet_2" {
  vpc_id     = aws_vpc.esell_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Names = "esell-subnet-2"
  }
}


#internet gateway Esell
resource "aws_internet_gateway" "esell_igw" {
  vpc_id = aws_vpc.esell_vpc.id

  tags = {
    Name = "esell-igw"
  }
}


#Route table for Esell (public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.esell_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.esell_igw.id
  }


  tags = {
    Name = "public_routetable"
  }
}


#route table for Esell (private)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.esell_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.esell_igw.id
  }


  tags = {
    Name = "private_routetable"
  }
}


