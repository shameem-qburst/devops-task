provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["/home/shameem/Important Docs/AWS/shameem AWS IAM access key/credentials"]
  profile = "shameem"
}

resource "aws_iam_role" "EKSClusterRole" {
  name = "EKSClusterRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "NodeGroupRole" {
  name = "EKSNodeGroupRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.EKSClusterRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.NodeGroupRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.NodeGroupRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.NodeGroupRole.name
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = "eks-cluster"
  role_arn = "arn:aws:iam::777445432602:role/EKSClusterRole" # aws_iam_role.EKSClusterRole.arn
  vpc_config {
    subnet_ids         = ["subnet-019a335d12c29e98c", "subnet-0f096b9fb6c80ead7", "subnet-02d6b6aa7ff0c63ed"]
    security_group_ids = ["sg-07bf09b10b0aeb44b"]
  }
}

resource "aws_eks_node_group" "eks_worker" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = "arn:aws:iam::777445432602:role/EKSNodeGroupRole" # aws_iam_role.NodeGroupRole.arn
  instance_types  = ["t2.small"]
  subnet_ids      = ["subnet-02d6b6aa7ff0c63ed", "subnet-0f096b9fb6c80ead7"]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}
