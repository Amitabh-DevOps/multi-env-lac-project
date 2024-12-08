resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "${var.env}-amitabh-devops-bucket"

  tags = {
    Name = "${var.env}-amitabh-devops-bucket"
    Environment = var.env
  }
}