resource "kubernetes_namespace" "example" {
  metadata {
    annotations = {
      name = var.namespace_metadata_annontations_name
    }

    labels = {
      mylabel = var.namespace_metadata_labels_name
    }

    name = "${var.namespace_metadata_name}"
  }
}