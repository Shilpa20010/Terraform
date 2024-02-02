data "databricks_aws_assume_role_policy" "assume_role_policy" {
  external_id = var.ACCOUNT_ID
}

data "databricks_aws_crossaccount_policy" "aws_crossaccount_policy" {

}

resource "aws_iam_role" "cross_account_role" {
  name = var.config["aws_iam_role_name"]
  assume_role_policy = data.databricks_aws_assume_role_policy.assume_role_policy.json
}

resource "aws_iam_role_policy" "role_policy" {
  name = var.config["aws_iam_role_policy_name"]
  policy = data.databricks_aws_crossaccount_policy.aws_crossaccount_policy.json
  role   = aws_iam_role.cross_account_role.id
}

#resource "databricks_mws_credentials" "credentials" {
#  credentials_name = var.config["mws_credential_name"]
#  role_arn = aws_iam_role.cross_account_role.arn
#  depends_on       = [aws_iam_role_policy.role_policy]
#  account_id       = var.ACCOUNT_ID
#}

