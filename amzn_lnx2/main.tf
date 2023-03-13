# Define Amazon Linux 2 AMI
data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


#============================================================================================


# Define security group
resource "aws_security_group" "instance" {
  name_prefix = "instance"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#============================================================================================

# Define Amazon Linux 2 instance
resource "aws_instance" "amzn2" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  key_name      = "access_key_mumbai_region"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "Amazon Linux 2"
  }

    user_data = <<-EOF
                #! /bin/bash
                sudo yum update
                sudo amazon-linux-extras install nginx1 -y
                sudo rm -rf /usr/share/nginx/html/*
                sudo echo "Hello, Welcome to Amazon Linux machine" >> /usr/share/nginx/html/index.html
                sudo nginx -t
                sudo systemctl restart nginx
        EOF

}

#============================================================================================

# Define Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}


#=============================================================================================


# Define two Ubuntu instances
resource "aws_instance" "ubuntu1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "access_key_mumbai_region"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "ubuntu1"
  }
    user_data = <<-EOF
                #! /bin/bash
                sudo apt update
                sudo apt install nginx -y
                sudo echo "Hello, Welcome to Ubuntu 1 Machine" >> /var/www/html/index.html
                sudo nginx -t
                sudo systemctl restart nginx
        EOF

}

resource "aws_instance" "ubuntu2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "access_key_mumbai_region"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "ubuntu2"
  }

    user_data = <<-EOF
                #! /bin/bash
                sudo apt update
                sudo apt install nginx -y
                sudo echo "Hello, Welcome to Ubuntu 2 Machine" >> /var/www/html/index.html
                sudo nginx -t
                sudo systemctl restart nginx
        EOF


}
