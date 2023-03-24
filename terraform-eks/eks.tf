####################################
# EKS Cluster

resource aws_eks_cluster "starfleet-eks-cluster" {
  name = "starfleet-eks-cluster"
  role_arn = aws_iam_role.starfleet-cluster-role.arn

  vpc_config {
    subnet_ids = module.vpc_network.subnet_ids
    endpoint_public_access = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.starfleet-cluster-policy
  ]
}

data "aws_iam_policy_document" "get_eks_role_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource aws_iam_role "starfleet-cluster-role" {
  name = "starfleet-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.get_eks_role_role.json
}

resource aws_iam_role_policy_attachment "starfleet-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.starfleet-cluster-role.name
}

####################################

# EKS NODE GROUP

resource "aws_eks_node_group" "starfleet-node-group" {
  cluster_name    = aws_eks_cluster.starfleet-eks-cluster.name
  node_group_name = "starfleet-node-group"
  node_role_arn   = aws_iam_role.starfleet-node-group-role.arn
  subnet_ids      = module.vpc_network.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "starfleet-node-group-role" {
  name = "starfleet-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.starfleet-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.starfleet-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.starfleet-node-group-role.name
}