
variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "iam_account" {
  description = "AWS IAM Account"
  default = "637423330852/devmarkpro"
}
variable "AWS_ACCESS_KEY_ID" {
  sensitive = true
  description = "AWS_ACCESS_KEY_ID"
  nullable = false
}

variable "AWS_SECRET_ACCESS_KEY" {
  sensitive = true
  description = "AWS_SECRET_ACCESS_KEY"
  nullable = false
}
