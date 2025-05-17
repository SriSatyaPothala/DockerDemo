### AWS EC2 instance creation using Terraform in two different regions using a single configuration file

## prerequisites
- Launch EC2 instance and install and configure AWS CLI and Terraform in it.
- Access keys for AWS CLI configuration

## Installation
#AWS INSTALLATION:
 - sudo apt update -y
 - sudo apt install -y curl unzip
 - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
 - unzip awscliv2.zip
 - sudo ./aws/install
 - aws --version

#CONFIGURE AWS CLI
- aws configure
#TERRAFORM INSTALLATION
- curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
- echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
- sudo apt update && sudo apt install terraform -y
- terraform -version

## Steps
- Create a configuration file called main.tf
- Write terraform script using provider block, resource block, output block to get the public_ip of the created instances.
- for creating instances in 2 different regions, use the concept of alias in terraform 

#WRITE TERRAFORM SCRIPT in main.tf
- terraform init
- terraform fmt
- terraform plan
- terraform apply   

Note: main.tf is the configuration file used 
and all the outputs are present in output_screenshots folder 
    