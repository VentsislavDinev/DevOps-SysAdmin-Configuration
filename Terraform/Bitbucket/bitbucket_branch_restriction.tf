# Manage your repositories branch restrictions
resource "bitbucket_branch_restriction" "master" {
  owner      = var.bitbucket_branch_restriction_owner
  repository = var.bitbucket_branch_restriction_repo

  kind = var.bitbucket_branch_restriction_kind
  pattern = var.bitbucket_branch_restriction_pattern
}