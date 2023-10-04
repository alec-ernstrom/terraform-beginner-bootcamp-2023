module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path # this was not here as of 10/4/23 - so was added in to resolve the error popping up
}

module "terratowns" {
  source = "./bin/terratowns"
}