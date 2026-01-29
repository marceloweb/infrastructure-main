variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "tags" {
  description = "Default tags"
  type        = map(string)
}
