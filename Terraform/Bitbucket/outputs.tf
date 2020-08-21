# Manage your repository
data "bitbucket_user" "reviewer" {
  username = "gob"
}
// render Bitbucket nickname
output "bitbucket_nickname" {
    value = "${join(",", data.bitbucket_user.reviewer.nickname)}"
    description = "Bitbucket nickname."
    sensitive   = false
}

