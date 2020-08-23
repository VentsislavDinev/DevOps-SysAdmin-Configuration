data "kubernetes_pod" "test" {
  metadata {
    name = "terraform-example"
  }
}