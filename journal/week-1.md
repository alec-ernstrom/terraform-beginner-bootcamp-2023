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

## Considerations with using LLM's

It's important to remember that even though LLM's are helpful for generating code, their learning may have been based on outdated information, which could cause issues for you.

## Working With Files In Terraform

### Path Variable

In Terraform, there is a special variable called `path` that allows us to reference local paths:

- ``path.module`` = Get the path for the current module
- ``path.root`` = Get the path for the root of the module

Use these values carefully, because they include information about the context in which a configuration is being applied and so may inadvertently hurt the portability or composability of a module.

For example, if you use ```path.cwd``` directly to populate a path into a resource argument then later applying the same configuration from a different directory or on a different computer with a different directory structure will cause the provider to consider the change of path to be a change to be applied, even if the path still refers to the same file.

An example of this might look like:

```sh
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath

  etag = filemd5(var.error_html_filepath)
}
```

[References to Named Values](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

### "```fileexists```" Function

fileexists determines whether a file exists at a given path.

```sh
fileexists(path)
```

Example of this might be:

```sh
condition = fileexists(var.error_html_filepath)
```

[fileexists Terraform Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)


### "```filemd5```" Function

filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.

This is similar to ```md5(file(filename))```, but because file accepts only UTF-8 text it cannot be used to create hashes for binary files.

Example of this might be something like:

```sh
etag = filemd5(var.error_html_filepath)
```

[filemd5 Terraform Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### "```etag```" Argument for "```aws_s3_object```"

"(Optional) Triggers updates when the value changes. The only meaningful value is ```filemd5("path/to/file")```(Terraform 0.11.12 or later) or ```${md5(file("path/to/file"))}``` (Terraform 0.11.11 or earlier). This attribute is not compatible with KMS encryption, ```kms_key_id``` or ```server_side_encryption = "aws:kms"```, also if an object is larger than 16 MB, the AWS Management Console will upload or copy that object as a Multipart Upload, and therefore the ETag will not be an MD5 digest (see ```source_hash``` instead)."

Example might be:

```sh
etag = filemd5(var.error_html_filepath)
```

[aws_s3_object "etag" Argument](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object#etag)

## Other References

[ToC Markdown Generator](https://ecotrust-canada.github.io/markdown-toc/)

