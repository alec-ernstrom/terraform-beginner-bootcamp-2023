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