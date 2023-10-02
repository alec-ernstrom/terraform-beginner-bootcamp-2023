terraform {
  cloud {
    organization = "alec_terra_org"
    workspaces {
      name = "terraform-cloud"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
  }
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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity

data "aws_caller_identity" "current" {}



module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  #index_html_filepath = var.index_html_filepath
  #error_html_filepath = var.error_html_filepath

}