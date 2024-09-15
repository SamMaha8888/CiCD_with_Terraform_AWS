resource "aws_iam_user" "infra_deployment_user" {
  name = "infra-deployment-user"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "eks_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "eks_worker_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_user_policy_attachment" "vpc_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "s3_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "ec2_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "cloudformation_access" {
  user       = aws_iam_user.infra_deployment_user.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"
}

resource "aws_iam_access_key" "infra_deployment_user_key" {
  user = aws_iam_user.infra_deployment_user.name
}

