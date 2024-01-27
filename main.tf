# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

################ Obsidian ##############

resource "aws_s3_bucket" "obsidian_bucket" {
  bucket = "devmarkpro-obsidian-vault"

  tags = {
    Name = "Obsidian Vault"
    App  = "Obsidian"
  }
}

# Define an IAM policy that grants full access to the S3 bucket
resource "aws_iam_policy" "obsidian_full_access" {
  name        = "ObsidianFullAccessPolicy"
  description = "Policy that grants full access to S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "s3:*",
      Effect = "Allow",
      Resource = [aws_s3_bucket.obsidian_bucket.arn, "${aws_s3_bucket.obsidian_bucket.arn}/*"]
    }]
  })
}

# Create an IAM role and attach the policy
resource "aws_iam_role" "obsidian_admin_role" {
  name = "ObsidianAdminRole"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3_admin_attachment" {
  policy_arn = aws_iam_policy.obsidian_full_access.arn
  role       = aws_iam_role.obsidian_admin_role.name
}