terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.83.0"     
        }
    }

    backend "s3" {
        bucket = "task-manager-terraform-state"
        key = "aws/ec2-deploy/terraform.tfstate"
    }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "todo-app" {
    ami = "ami-023a307f3d27ea427"
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.todo-app.id]
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = var.private_key
        timeout = "4m"
    }

    tags = {
        "name" = "todo-app"
    }
}

resource "aws_iam_instance_profile" "ec2_profile" {  // Updated name
    name = "ec2-profile"
    role = "EC2-AUTH"
}

resource "aws_security_group" "todo-app" {
    egress = [
        {
            cidr_blocks = ["0.0.0.0/0"]
            description = ""
            from_port = 0
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            protocol = "-1"
            security_groups = []
            self = false
            to_port = 0  
        }
    ] 
    ingress = [
        {
            cidr_blocks = ["0.0.0.0/0"]
            description = ""
            from_port = 22
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            protocol = "tcp"
            security_groups = []
            self = false
            to_port = 22
        },
        {
            cidr_blocks = ["0.0.0.0/0"]
            description = ""
            from_port = 0
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            protocol = "tcp"
            security_groups = []
            self = false
            to_port = 0
        }
    ]
}

resource "aws_key_pair" "todo-terraform" {
    key_name = var.key_name
    public_key = var.public_key
}

output "instance_public_ip" {
    value = aws_instance.todo-app.public_ip
    sensitive = false
}
