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

    resource "aws_instance" "appserver01" {
    ami = "ami-0af9569868786b23a"
    instance_type = "t2.micro"
     subnet_id = "subnet-098507cf9fcaaccbc"

    tags = {
        env = "dev"
    }
    }
    resource "aws_instance" "appserver02" {
    provider = aws.west
    ami = "ami-06c8f2ec674c67112"
    instance_type = "t2.micro"

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

