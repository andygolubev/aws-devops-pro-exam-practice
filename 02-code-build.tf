resource "aws_codebuild_project" "hello_world" {
  name          = "Hello-world-project"
  description   = "Hello world project using CodeBuild with GitHub"
  build_timeout = "5"
  service_role  = aws_iam_role.hw_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
  }

  source {
    type              = "GITHUB"
    location          = "https://github.com/andygolubev/aws-devops-pro-exam-practice.git"
  }
}

resource "aws_iam_role" "hw_role" {
  name = "hw_codebuild_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "hw_role_policy" {
  name = "hw_codebuild_policy"
  role = aws_iam_role.hw_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "secretsmanager:GetSecretValue",
        ]
        Resource = "*"
        Effect   = "Allow"
      },
    ]
  })
}
