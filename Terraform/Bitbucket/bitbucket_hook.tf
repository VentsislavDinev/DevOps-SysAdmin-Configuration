# Manage your repositories hooks
resource "bitbucket_hook" "deploy_on_push" {
  owner       = var.hook_owner
  repository  = var.hook_repository
  url         = var.url
  description = var.description

  events = [
    var.events,
  ]
}