# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "obsidian_bucket" {
  bucket = "devmarkpro-obsidian-vault"

  tags = {
    Name = "Obsidian Vault"
    App  = "Obsidian"
  }
}