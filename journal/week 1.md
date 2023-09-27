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

## ToC Markdown Generator

https://ecotrust-canada.github.io/markdown-toc/

## Terraform Cloud Variables

In Terraform we can set 2 kinds of variables:

- Environment Variables - ``These are set in your bash terminal``
- Terraform Variables - ``These are set within a file like 'tfvars'``

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

We can use the `-var` flag to set an input variable or override a variable in the tfvars file.

### var-file flag

- TODO: document this functionality for Terraform Cloud

### terraform.tfvars

This is the default file to load in Terraform variables in bulk

### auto.tfvars

- TODO: document which Terraform Variables take precedence 