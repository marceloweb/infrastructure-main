terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

module "ecr" {
  source = "./modules/ecr_repository"

  repository_name = var.repository_name
  tags            = var.tags
}

module "iam_role" {
  source = "./modules/iam"

  role_name = "eks-role-${var.environment}"
  tags      = var.tags
}

module "eks" {
  source = "./modules/eks_cluster"

  cluster_name     = var.cluster_name
  cluster_role_arn = module.iam_role.arn
  subnet_ids       = module.network.private_subnet_ids
  instance_type    = var.instance_type
  desired_size     = 2
  min_size         = 1
  max_size         = 3
  tags             = var.tags
}

resource "null_resource" "update_kubeconfig" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
  }
}

module "rds" {
  source = "./modules/rds"

  environment                   = var.environment
  vpc_id                        = module.network.vpc_id
  subnet_ids                    = module.network.private_subnet_ids
  db_username                   = var.db_username
  db_password                   = var.db_password
  db_name                       = var.db_name
  db_engine                     = var.db_engine
  db_engine_version             = var.db_engine_version
  db_instance_class             = var.db_instance_class
  eks_cluster_security_group_id = module.eks.cluster_security_group_id
  tags                          = var.tags
}