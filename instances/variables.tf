variable "region" {
  default = "us-west-2"
}
variable "key_name" {}
variable "private_key_path" {}
variable "security_group_id" {}
variable "instance_type" {
  default = "t2.micro"
}
# Amazon Linux AMI
variable "amis" {
  default = {
    us-west-2 = "ami-79873901"  #most recent t2.micro AMI as of 9th March, 2018.
  }
}

variable "exec_commands" {
    default = [
        "command curl -sSL https://rvm.io/mpapis.asc | gpg --import -",
        "\\curl -sSL https://get.rvm.io | bash -s stable --rails",
        "gem install bundler",
        "git clone https://github.com/spsiddarthan/sample-app",
        "cd sample-app",
        "sudo bundle install",
        "exec > >(tee /var/log/install-rails-and-start-app.log|logger -t install-rails-and-start-app  -s 2>/dev/console) 2>&1",
        "echo \"Starting Ruby on Rails app\"",
        "rails -s &"
    ]
}
