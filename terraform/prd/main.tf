module "comments_ecr_prd" {
  source = "../modules/ecr_repository"
  repository_name = "example-app-prd"
}

module "eks_prd" {
  source = "../modules/eks_cluster"

  cluster_name     = "example-app-cluster-prd"
  cluster_role_arn = "arn:aws:iam::${var.account_id}:role/eks-role-prd"
  subnet_ids       = ["subnet-ghi", "subnet-jkl"]
}