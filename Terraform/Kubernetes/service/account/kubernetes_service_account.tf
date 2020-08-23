/*
A service account provides an identity for processes that run in a Pod.
*/
resource "kubernetes_service_account" "example" {
  metadata {
    name = "${var.service_account_metadata_name}"
  }
  secret {
    name = "${kubernetes_secret.example.metadata.0.name}"
  }
}