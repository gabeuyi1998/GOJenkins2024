terraform {
  backend "s3" {
    bucket         = "go-lambda-s3"
    key            = "terraform/state"
    region         = "ap-southeast-2"
    dynamodb_table = "GO-TFState-table"
    encrypt        = true
  }
}