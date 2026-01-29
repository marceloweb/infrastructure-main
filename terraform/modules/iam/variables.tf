variable "role_name" {
  description = "IAM role"
  type        = string
}

variable "tags" {
  description = "Default tags"
  type        = map(string)
}
