# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

################ Obsidian ##############

resource "aws_s3_bucket" "obsidian_bucket" {
  bucket = "devmarkpro-obsidian-vault"

  tags = {
    Name = "App"
    App  = "Obsidian"
  }
}

# Define an IAM policy that grants full access to the S3 bucket
resource "aws_iam_policy" "obsidian_full_access" {
  name        = "ObsidianFullAccessPolicy"
  description = "Policy that grants full access to obsidian"
  
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
resource "aws_iam_role_policy_attachment" "obsidian_s3_admin_attachment" {
  policy_arn = aws_iam_policy.obsidian_full_access.arn
  role       = aws_iam_role.obsidian_admin_role.name
}


################ Podcasts ##############

resource "aws_s3_bucket" "podcast_bucket" {
  bucket = "devmarkpro-podcasts"

  tags = {
    Name = "App"
    App  = "Podcast"
  }
}

# Define an IAM policy that grants full access to podcast
resource "aws_iam_policy" "podcast_full_access" {
  name        = "PodcastFullAccessPolicy"
  description = "Policy that grants full access to podcast"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "s3:*",
      Effect = "Allow",
      Resource = [aws_s3_bucket.podcast_bucket.arn, "${aws_s3_bucket.podcast_bucket.arn}/*"]
    }]
  })
}

# Create an IAM role and attach the policy
resource "aws_iam_role" "podcast_admin_role" {
  name = "PodcastAdminRole"
  
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
resource "aws_iam_role_policy_attachment" "podcast_s3_admin_attachment" {
  policy_arn = aws_iam_policy.podcast_full_access.arn
  role       = aws_iam_role.podcast_admin_role.name
}
