terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.70.0" # latest version from https://registry.terraform.io/providers/hashicorp/aws/latest
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.al2023.id
  instance_type = "t3.micro"

  user_data = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  vpc_security_group_ids = [aws_security_group.web.id]
}

resource "aws_security_group" "web" {
  name = "web"
  description = "Allow HTTP (TCP port 80) from my IP and all outbound traffic"

  tags = {
    Name = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_my_ip" {
  security_group_id = aws_security_group.web.id
  description = "HTTP (TCP port 80) from my IP"
  cidr_ipv4 = var.my_ip # from variables.tf
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.web.id
  description = "Allow all outbound traffic"
  cidr_ipv4 = "0.0.0.0/0" # all ipv4 addresses
  ip_protocol = "-1" # all protocols
}
