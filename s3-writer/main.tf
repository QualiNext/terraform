provider "aws" {
  region     = "eu-west-1"
  access_key = var.AWS_ACCESS_KEY == "none" ? "" : var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS == "none" ? "" : var.AWS_SECRET_ACCESS
}

resource "aws_s3_bucket_object" "object" {
  bucket  = var.BUCKET_NAME
  key     = var.SANDBOX_ID
  acl     = "bucket-owner-full-control"
  content = <<EOF
USER_CONTENT:${var.USER_CONTENT}
SERVER_NAME:${var.SERVER_NAME}
SERVER_VERSION:${var.SERVER_VERSION}
OUTPUTS_PUBLISHER_STR_OLD:${var.OUTPUTS_PUBLISHER_STR_OLD}
OUTPUTS_PUBLISHER_STR:${var.OUTPUTS_PUBLISHER_STR}
OUTPUTS_PUBLISHER_SPECIAL_CHARS_STR:${var.OUTPUTS_PUBLISHER_SPECIAL_CHARS_STR}
VIRTUAL_NETWORK_ID_NEW:${var.VIRTUAL_NETWORK_ID_NEW}
VIRTUAL_NETWORK_ID:${var.VIRTUAL_NETWORK_ID}
PUBLIC_ADDRESS_NEW:${var.PUBLIC_ADDRESS_NEW}
PUBLIC_ADDRESS:${var.PUBLIC_ADDRESS}
PUBLIC_ADDRESS_OLD:${var.PUBLIC_ADDRESS_OLD}
SANDBOX_ID_NEW:${var.SANDBOX_ID_NEW}
SANDBOX_ID:${var.SANDBOX_ID}
SANDBOX_ID_OLD:${var.SANDBOX_ID_OLD}
LITERAL_PARAMETER:${var.LITERAL_PARAMETER}
AWS_SSM_PARAMETER:${var.AWS_SSM_PARAMETER}
OUTPUTS:${var.OUTPUTS}
ALL_IN_ONE:${var.ALL_IN_ONE}
EOF
}

data "external" "presign" {
  program = ["bash", "presign.sh", var.BUCKET_NAME, var.SANDBOX_ID, var.AWS_ACCESS_KEY, var.AWS_SECRET_ACCESS]
}

output "s3_file_url" {
  value = data.external.presign.result.url
}

