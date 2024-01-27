# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "obsidian_s3_bucket_arn" {
  value = aws_s3_bucket.obsidian_bucket.arn
}
