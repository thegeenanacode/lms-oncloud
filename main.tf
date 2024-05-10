terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"  # Choose the region appropriate for your deployment
}

module "networking" {
  source = "./modules/networking"
  # Pass variables to the module if needed
  vpc_cidr = "10.0.0.0/16"
}


module "compute" {
  source    = "./modules/compute"
  subnet_id = module.networking.subnet_id  # Passing subnet ID as a variable
}