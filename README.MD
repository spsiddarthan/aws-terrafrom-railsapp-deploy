# Problem statement 
Please generate Terraform code that will provision a complete AWS infrastructure capable of supporting a Ruby on Rails application. You should consider data, scaling, security, access and reuse.

# Solution 
A VPC was created first and it consists of both private and public subnets. The prod version of the app (https://github.com/spsiddarthan/sample-app, a simple barebones rails app) will run on an ec-2 instance (all the instnaces used are t2.micro) launched in the public subnet and the beta version will run on an ec-2 instance private subnet (so that it's not accessible to everyone, ideally something like a prod-db or a redis store would be put in a private network, in this example, I decided to put the beta version of the app on a private networks to illustrate how to create a VPC and the public and private subets). The instance module has the necessary code to install rails, clone the app and start it. The beta and the prod enviroments have their owne security groups defined as well to control ingress and egress. The main.tf file in the root directory declares the provider and calls the vpc module. The VPC module creates a default vpc, a default internet gateway, a NAT instance, security groups and instances (by invoking the instances module). 

# Todo

The pending items, Auto-scaling and IAM roles will be added over the next 24 hours. 

# Pre Requisites

1. Please have terraform installed. 
2. Please configure the necessary AWS creds using the AWS-CLI.
3. Have a local copy of the .pem file using which will be used to ssh onto the instances. 

# Execution

1. ```terraform plan -var "key_name=terraform-deploy-keypair"  -var "private_key_path=$HOME/.ssh/terraform-deploy-keypair.pem"```
2. ```terraform apply -var "key_name=terraform-deploy-keypair"  -var "private_key_path=$HOME/.ssh/terraform-deploy-keypair.pem"```

