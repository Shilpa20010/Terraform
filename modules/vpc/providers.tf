terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.9.2"
    }
  }
}