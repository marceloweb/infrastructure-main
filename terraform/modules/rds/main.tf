resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group-xyz-${var.environment}"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg-xyz-${var.environment}"
  description = "Allow inbound traffic from EKS cluster."
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "db_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = var.eks_cluster_security_group_id
  description              = "Allow traffic from EKS cluster."
}

resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.db_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}

resource "aws_db_instance" "mariadb" {
  allocated_storage      = 20
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  tags                   = var.tags
}