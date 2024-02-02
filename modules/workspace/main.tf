
data "aws_iam_role" "this" {
  name = "shilpacuebox1"
}


resource "databricks_mws_credentials" "credentials" {
  credentials_name = var.config["mws_credential_name"]
  role_arn = data.aws_iam_role.this.arn
  account_id       = var.ACCOUNT_ID
}


resource "databricks_mws_storage_configurations" "this" {
  account_id                 = var.ACCOUNT_ID
  bucket_name                = var.config["bucket_name"]
  storage_configuration_name = var.config["storage_configuration_name"]
}

resource "databricks_mws_workspaces" "this" {
  account_id     = var.ACCOUNT_ID
  aws_region     = var.region
  workspace_name = var.config["db_workspacename"]
  credentials_id = databricks_mws_credentials.credentials.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
}
