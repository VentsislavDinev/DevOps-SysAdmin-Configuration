# Manage your repository
resource "bitbucket_repository" "infrastructure" {
  owner = var.bitbucket_repo_owner
  name  = var.bitbucket_repo_name
}