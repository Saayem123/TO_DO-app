terraform {
    #  AWS Provider configuration
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
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
    ami = "023a307f3d27ea427"
    instance_type = "t2.micro"
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.todo-app.id]


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
            cidr_blocks = ["0.0.0.0/0", ]
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
            cidr_blocks = ["0.0.0.0/0", ]
            description = ""
            from_port = 00
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            protocol = "tcp"
            security_groups = []
            self = false
            to_port = 00
        }
    ]
}

resource "aws_key_pair" "deployer" {
    key_name =var.key_name
    public_key = var.public_key

}
