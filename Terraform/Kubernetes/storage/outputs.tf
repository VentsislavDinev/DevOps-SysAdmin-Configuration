data "kubernetes_storage_class" "example" {
  metadata {
    name = "terraform-example"
  }
}