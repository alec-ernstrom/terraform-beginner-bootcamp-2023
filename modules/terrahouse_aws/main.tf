terraform {
#  cloud {
#    organization = "alec_terra_org"
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
  required_providers {
#    random = {
#      source = "hashicorp/random"
#      version = "3.5.1"
#  }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0" 
    }
  }
}

# The below lines are no longer needed for for your configuration:

#provider "aws" {
#  # Configuration options
#}

#" Warning: Redundant empty provider block
#│ 
#│   on modules/terrahouse_aws/main.tf line 20:
#│   20: provider "aws" {
#│ 
#│ Earlier versions of Terraform used empty provider blocks ("proxy provider configurations") for child modules to declare their need to be passed a provider configuration by their callers. That approach was ambiguous and is now
#│ deprecated.
#│ 
#│ If you control this module, you can migrate to the new declaration syntax by removing all of the empty provider "aws" blocks and then adding or updating an entry like the following to the required_providers block of
#│ module.terrahouse_aws:
#│     aws = {
#│       source = "hashicorp/aws"
#│     }
#│ 
#│ (and one more similar warning elsewhere)"



## Random String Documentation: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
#resource "random_string" "bucket_name" {
#  upper            = false
#  length           = 32
#  special          = false
#}
#
# Commands for bucket creation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "website_bucket" {
  # Bucket Name Rules: https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}
