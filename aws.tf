provider "aws" {
  access_key = "<ACCESS_KEY>"
  secret_key = "<SECRET_KEY>"
  region     = "us-east-1"
}

data "aws_region" "current" {
  current = true
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_security_group" "sg_jenkins" {
  name = "jenkins"
  description = "Allows all traffic"

  vpc_id = "${data.aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 8080
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

resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC30hPSHsE04QeH+pkdadetmEO0nxMmG+Da58pC2o4jboY7pDQBKBsCAoq+cMnyDVdHhRI4W7Gptr2u1Jq+hFPTv2LKn9U9l5/O/SSDRVtskfk3/PXT/Z7HljZrVH3sRRUJZdmUh/0VCkdF+AW3aP6UQPM0iVENiF5yY+Jnmw0hP88q+LpWL0EKAvgzwuYmrvXqt7Jxfu7oEvDeINatW77ruwf3dgbz5n8Q5V0fkDzV+G5qj1sYbOD2JM6hhLwdDC8Fxb8BtJRluq+vBW9vGuJXibyo7kHxbj2APeNcGzqeMD9ZGL9BfyTPYaUt/Jtdq67X9dPCOuNo4ZjLg0M6P/AN kaushikc@in-kaushikc.local"
}
