variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

## The function ```can``` evaluates the given expression and returns a boolean value indicating whether the expression produced a result without any errors. 
## https://developer.hashicorp.com/terraform/language/functions/can

variable "bucket_name" {
  description = "Name of the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{1,255}$", var.bucket_name))
    error_message = "Bucket name must be 1-255 characters long and can only contain alphanumeric characters, hyphens, and periods."
  }
}

variable "index_html_filepath" {
  type = string

  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist."
  }
}

variable "error_html_filepath" {
  type = string

  validation {
    condition = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist."
  }
}

variable "content_version" {
  description = "The content version (positive integer starting at 1)"
  type        = number

  validation {
    condition = var.content_version >= 0 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}