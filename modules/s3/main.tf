data "databricks_aws_bucket_policy" "this" {
  bucket = "shilpacueboxbucket1"
}


resource "aws_s3_bucket" "root_storage_bucket" {
  bucket = var.config["aws_s3_bucket_name"]
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root_storage_bucket" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.config["algorithm"]
    }
  }
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = aws_s3_bucket.root_storage_bucket.id
  policy     = data.databricks_aws_bucket_policy.this.json
}




