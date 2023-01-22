terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    encrypt        = true
    dynamodb_table = "terraform_state_lock_db"
    bucket         = "nzoun-terraform-bucket"
    key            = "nzoun"
    region         = "us-east-1"
  }


}
