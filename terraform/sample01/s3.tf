resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-stu"
  acl    = "private"

  tags {
    Name        = "Test Bucket"
    Environment = "Dev"
  }
}