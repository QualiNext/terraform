provider "aws" {
  region = "eu-west-1"
  access_key = var.AWS_ACCESS_KEY == "none" ? "" : var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS == "none" ? "" : var.AWS_SECRET_ACCESS
}

resource "aws_security_group" "allow_all" {
  name        = "tintin_sg_test_main"
  description = "SG that allow TLS inbound traffic"
  # vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = aws_vpc.main.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ter-tags-test-main",
    Owner = "tintin"
  }
}

module "test_me_please" {
    source = "./module_test"
}
