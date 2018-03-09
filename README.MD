# This file will be heavily modified in the future. 

As of now, this terraform config boots up a t2.micro instance and clones the sample-repo repo from my account
and runs it. 

Plan for tomorrow is to deploy two different environments - namely beta and prod, taking care to reuse code using the 
modules. The two environments will have different access controls (at this stage, I am thiking IAM roles should sufffice here_/ 

The two environments will also have different security groups. 

On the local host, you should have installed the aws-cli and have the credentials configured. You should also have terraform 
installed.
