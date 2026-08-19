terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "remote-tr-state-file-vpc-1"
    key          = "robo-shop-EC2.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }

}


provider "aws" {
  region = "ap-south-1"
}