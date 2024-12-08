resource "aws_dynamodb_table" "my_table" {
  name = "${var.env}-devops-db-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  tags = {
    Name = "${var.env}-devops-db"
    Environment = var.env
  }
}