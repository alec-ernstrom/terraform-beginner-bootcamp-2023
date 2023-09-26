# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Out Root Module Structure is as follows:

-PROJECT_ROOT
  - ``variables.tf`` - stores the structure of input variables
  - ``main.tf`` - everything else
  - ``providers.tf`` - defines required providers and their configs
  - ``outputs.tf`` - stores our outputs
  - ``terraform.tfvars`` - the data of variables we want to load into our terraform project
  - ``README.md`` - required for root modules

[Standard Module Strucuture](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
