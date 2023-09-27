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
