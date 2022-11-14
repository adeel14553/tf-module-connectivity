provider "aws" {
  # access_key = "add-your-key"
  # secret_key = "add-your-access_key"
  # region     = var.aws_region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "aws-terraform"
}
