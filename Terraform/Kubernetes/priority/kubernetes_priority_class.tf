resource "kubernetes_priority_class" "example" {
  metadata {
    name = "${var.priority_class_metadata_name}"
  }

  value = "${var.priority_class_metadata_value}"
}