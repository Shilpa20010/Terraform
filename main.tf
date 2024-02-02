locals {
  data    = jsondecode(file("${path.module}/config/config.json"))
}

module "iam_role" {
  providers = {
    databricks= databricks.accounts
  }
  source = "./modules/iam"
  for_each      = {for entry in local.data["iam_role"] : entry["aws_iam_role_name"] => entry}
  config = each.value
  ACCOUNT_ID = var.ACCOUNT_ID
}
module "s3_bucket" {
  providers = {
    databricks = databricks.accounts
  }
  source = "./modules/s3"
  for_each      = {for entry in local.data["s3"] : entry["aws_s3_bucket_name"] => entry}
  config = each.value
  ACCOUNT_ID = var.ACCOUNT_ID

}

module "db_workspace" {
  providers = {
    databricks = databricks.accounts
  }
  source = "./modules/workspace"
  for_each      = {for entry in local.data["db_workspace"] : entry["storage_configuration_name"] => entry}
  config = each.value
  ACCOUNT_ID = var.ACCOUNT_ID
  region = var.region

}
