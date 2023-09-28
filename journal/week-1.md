# Terraform Beginner Bootcamp 2023 - Week 1

### Table of Contents

- [Root Module Structure](#root-module-structure)
- [Terraform Cloud Variables](#terraform-cloud-variables)
  * [Loading Terraform Input Variables](#loading-terraform-input-variables)
  * [var-file flag](#var-file-flag)
  * [terraform.tfvars](#terraformtfvars)
  * [auto.tfvars](#autotfvars)
- [Dealing With Configuration Drift](#dealing-with-configuration-drift)
  * [Importing Terraform State with ``Import`` and Avoid Replacement](#importing-terraform-state-with---import---and-avoid-replacement)

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

## Dealing With Configuration Drift


### Importing Terraform State with ``Import`` and Avoid Replacement

Import will find the existing resource from ID and import it into your Terraform state.

https://developer.hashicorp.com/terraform/cli/commands/import#provider-configuration

When importing a resource using the ``random_string`` resource option, if configuration isn't specifically set, the resource you're importing will be destroyed and recreated the next time ```terraform apply``` is run. The resolution for this is the specifically call out the configuration, as seen in this URL:

https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string#avoiding-replacement

When using AWS, the ```import``` commands for the AWS provider can be found here:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import

## Fix Using Terraform Refresh 

```sh
terraform apply -refresh-only --auto-approve
```

## Terraform Modules

It is recommended to place modules in a ```modules``` directory when locally developing modules, but this is not a hard and fast rule.

### Passing Input Variables

You'll put theses lines into your ```main.tf``` file for your project, to pass input variables into your module. The module has to declare the Terraform variables in its own ```variables.tf```.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import he module from various place eg:

- Locally
- Github
- Terraform Registry

## Other References

[ToC Markdown Generator](https://ecotrust-canada.github.io/markdown-toc/)

