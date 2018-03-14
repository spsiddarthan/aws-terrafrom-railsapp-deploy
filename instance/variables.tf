variable "region" {
  default = "us-west-2"
}
variable "key_name" {}
variable "name" {}
variable "subnet_id" {}
variable "private_key_path" {}
variable "vpc_security_group_ids" {
    type = "list"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "associate_public_ip_address" {}
variable "source_dest_check" {}
variable "tags" {}

# Amazon Linux AMI
variable "amis" {
  default = {
    us-west-2 = "ami-79873901"  #most recent t2.micro AMI as of 9th March, 2018.
  }
}


variable "exec_commands" {
    default = [
        "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -",
        "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -",
        "echo \"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list",
        "sudo apt-get update",
        "sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn",
        "cd",
        "wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz",
        "tar -xzvf ruby-2.5.0.tar.gz",
        "cd ruby-2.5.0/",
        "./configure",
        "make",
        "sudo make install",
        "ruby -v",
        "sudo gem install bundler",
        "sudo gem install rails",
        "cd",
        "git clone https://github.com/spsiddarthan/sample-app",
        "cd sample-app",
        "echo \"Starting Ruby on Rails app\"",
        "rails -s &"
    ]
}
