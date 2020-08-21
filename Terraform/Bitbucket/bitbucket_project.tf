# Manage your repository
resource "bitbucket_project" "devops" {
  owner = var.bitbucket_project_owner
  name  = var.bitbucket_project_name
  key =  var.bitbucket_project_key
}