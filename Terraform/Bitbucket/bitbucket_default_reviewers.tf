# Manage your repositories default reviewers
data "bitbucket_user" "reviewer" {
  username = var.bitbucket_user
}

resource "bitbucket_default_reviewers" "infrastructure" {
  owner      = var.owner
  repository = var.repository

  reviewers = [
    "${data.bitbucket_user.reviewer.uuid}",
  ]
}