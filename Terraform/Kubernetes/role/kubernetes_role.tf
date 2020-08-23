resource "kubernetes_role" "example" {
  metadata {
    name = "${var.role_metadata_name}"
    labels = {
      test = var.role_metadata_labels_test
    }
  }

  rule {
    api_groups     = "${var.role_metadata_api_groups}"
    resources      = "${var.role_metadata_resources}"
    resource_names = "${var.role_metadata_resource_names}"
    verbs          = "${var.role_metadata_verbs}"
  }
}