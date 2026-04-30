terraform {
  backend "s3" {
    bucket         = "sid-tf-s3-bucket" # Change to a unique name
    key            = "assignments/part3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}