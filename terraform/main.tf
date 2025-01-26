terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "task-manager-terraform-state"
    key    = "aws/ec2-deploy/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "todo-app" {
  ami                         = "ami-023a307f3d27ea427"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.todo-app.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = var.private_key
    timeout     = "4m"
  }

  tags = {
    "name" = "todo-app"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = "EC2-AUTH"
}

resource "aws_security_group" "todo-app" {
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all outbound traffic"
    from_port        = 0
    ipv6_cidr_blocks = []
    protocol         = "-1"
    to_port          = 0
  }]

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow SSH"
      from_port        = 22
      ipv6_cidr_blocks = []
      protocol         = "tcp"
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow HTTP"
      from_port        = 80
      ipv6_cidr_blocks = []
      protocol         = "tcp"
      to_port          = 80
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow HTTPS"
      from_port        = 443
      ipv6_cidr_blocks = []
      protocol         = "tcp"
      to_port          = 443
    }
  ]
}

resource "aws_key_pair" "todo-terraform" {
  key_name   = var.key_name
  public_key = var.public_key
}

output "instance_public_ip" {
  value = aws_instance.todo-app.public_ip
  # Temporarily remove sensitive for debugging
  # sensitive = true
}
