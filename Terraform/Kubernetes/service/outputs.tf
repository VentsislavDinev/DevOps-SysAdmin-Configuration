data "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
  }
}
