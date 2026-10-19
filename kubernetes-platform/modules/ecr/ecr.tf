resource "aws_ecr_repository" "ecr" {
  name = var.repository_name

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Name = var.repository_name
  }
}

resource "aws_ecr_repository_policy" "ecr" {
  repository = aws_ecr_repository.ecr.name
  policy     = data.aws_iam_policy_document.ecr_policy.json
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

  actions = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchDeleteImage",
    "ecr:BatchGetImage",
    "ecr:CompleteLayerUpload",
    "ecr:DeleteRepository",
    "ecr:DeleteRepositoryPolicy",
    "ecr:DescribeRepositories",
    "ecr:GetDownloadUrlForLayer",
    "ecr:GetRepositoryPolicy",
    "ecr:InitiateLayerUpload",
    "ecr:ListImages",
    "ecr:PutImage",
    "ecr:SetRepositoryPolicy",
    "ecr:UploadLayerPart"
    ]
  }
}
