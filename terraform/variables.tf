variable "cluster_name" {
  type        = string
  description = "description"
}

variable "aws_region" {
  type        = string
  description = "description"
}

variable "cluster_role_arn" {
  type        = string
  description = "description"
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "description"
}

variable "repository_name" {
  type        = string
  description = "description"
}

variable "project_name" {
  type        = string
  description = "description"
}

variable "environment" {
  type        = string
  description = "description"
}

variable "vpc_cidr" {
  type        = string
  description = "description"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
}

variable "db_username" {
  description = "Database master username."
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name."
  type        = string
  sensitive   = true
}

variable "db_engine" {
  description = "The database engine"
  type        = string
  default     = "mariadb"
}

variable "db_engine_version" {
  description = "The engine version of the database."
  type        = string
  default     = "11.4.8"
}

variable "db_instance_class" {
  description = "The instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "tags" {
  description = "Tags padronizadas"
  type        = map(string)
}