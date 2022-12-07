provider "aws" {
  region = "eu-west-1"
}

locals {
  common_tags = {
    creator        = "terraform"
  }
  
  initiator = "probably torque"
}

resource "aws_s3_bucket_object" "object" {
  bucket  = "${var.BUCKET_NAME}"
  key     = "${var.SANDBOX_ID}.json"
  #content = "{ \"Content\": \"${var.CONTENT}\"}"
  content = <<EOF
Content: ${var.CONTENT}
EOF
  
  tags = merge(
    local.common_tags,
    {
      "custom-tag-2" = local.initiator
    }
  )
}
