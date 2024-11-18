terraform {
  backend "s3" {
    bucket = "s3test.bucket25" #Bucket name here##
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
} 