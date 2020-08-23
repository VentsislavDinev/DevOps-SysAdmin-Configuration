resource "kubernetes_storage_class" "example" {
  metadata {
    name = "${var.storage_class_metadata_name}"
  }
  storage_provisioner =  "${var.storage_class_storage_provisioner}"
  reclaim_policy      =  "${var.storage_class_reclaim_policy}"
  parameters = {
    type = var.storage_class_parameters_type
  }
  mount_options ="${var.storage_class_mount_options}"
}