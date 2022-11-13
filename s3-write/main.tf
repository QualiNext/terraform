provider "aws" {
  region = "eu-west-1"
}

locals {
  common_tags = {
    creator        = "terraform"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket  = "${var.BUCKET_NAME}"
  key     = "${var.SANDBOX_ID}.json"
  content = "{ \"Content\": \"${var.CONTENT}\"}"
  
  tags = merge(
    local.common_tags,
    {
      custom_tag_1 = "val1"
      "custom_tag_2" = "val2"
    }
  )
}
