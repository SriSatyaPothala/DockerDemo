        terraform {
        required_providers {
            aws = {
                version = "~>5.0"
            }
        }
        }

        provider "aws" {
        region = "ap-south-1"
        }
        provider "aws" {
        alias = "west"
        region = "us-east-2"
        }
        
        resource "aws_security_group" "appserver01_sg" {
        name = "appserver01_sg"
        description = "Allows neccessary inbound and outbound traffic"

        ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
            from_port = 0
            to_port = 0 
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
        }
        resource "aws_instance" "appserver01" {
            ami = "ami-0e35ddab05955cf57"
            instance_type = "t2.micro"
            subnet_id = "subnet-098507cf9fcaaccbc"
            key_name = "key01"
            vpc_security_group_ids = [aws_security_group.appserver01_sg.id]
            user_data = <<-EOF
                        #!/bin/bash
                        sudo apt update -y
                        sudo apt install nginx -y
                        sudo systemctl enable nginx
                        sudo systemctl start nginx
                    EOF
            tags = {
                env = "dev"
            }
        }
        resource "aws_security_group" "appserver02_sg" {
        provider = aws.west
        name = "appserver02_sg"
        description = "Allows neccessary inbound and outbound traffic"

        ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
            from_port = 0
            to_port = 0 
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
        }
        resource "aws_instance" "appserver02" {
            provider = aws.west
            ami = "ami-06c8f2ec674c67112"
            instance_type = "t2.micro"
            key_name = "keyT"
            vpc_security_group_ids = [aws_security_group.appserver02_sg.id]
            user_data = <<-EOF
                    #!/bin/bash
                    sudo dnf update -y
                    sudo dnf install nginx -y
                    sudo systemctl enable nginx
                    sudo systemctl start nginx
                EOF
            tags = {
                env = "prod"
            }
        }
        output "appserver01_ip" {
        value = aws_instance.appserver01.public_ip
        }

        output "appserver02_ip" {
        value = aws_instance.appserver02.public_ip
        }

