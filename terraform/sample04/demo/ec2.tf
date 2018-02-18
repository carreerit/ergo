resource "aws_instance" "web" {
  ami           = "ami-428aa838"
  instance_type = "${var.INSTANCE_TYPE}"
  key_name = "devops"
  vpc_security_group_ids = ["sg-413b7736"]
  availability_zone = "us-east-1a"

  tags {
    Name = "terraform-test"
  }
}

resource "aws_ebs_volume" "test" {
    availability_zone = "us-east-1a"
    size = 10
    tags {
        Name = "test-volume"
    }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.test.id}"
  instance_id = "${aws_instance.web.id}"
}

