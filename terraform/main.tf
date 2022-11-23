terraform {
  cloud {
    organization = "arshsahzad"
    workspaces {
      name = "DryRunTest"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-090006f29ecb2d79a"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

