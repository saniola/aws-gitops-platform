terraform {
  backend "s3" {
    bucket         = "replace-with-unique-terraform-state-bucket"
    key            = "terraform-foundation/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
