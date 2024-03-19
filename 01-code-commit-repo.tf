resource "aws_codecommit_repository" "myrepo" {
  repository_name = "MyRepo"
  description     = "This is the Sample App Repository"
}