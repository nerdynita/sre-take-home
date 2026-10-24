terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.70.0"   # current major version from registry.terraform.io/providers/hashicorp/aws
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"
}
