provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recen    t = true

  filter {
    name   = "name"
    values = ["example"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["973714476881"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    Name = "HelloWorld"
  }
}