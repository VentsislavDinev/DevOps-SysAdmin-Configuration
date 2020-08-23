/*
The resource provides a piece of networked storage in the cluster provisioned by an administrator. It is a resource in the cluster just like a node is a cluster resource. Persistent Volumes have a lifecycle independent of any individual pod that uses the PV.
*/
resource "kubernetes_persistent_volume" "example" {
  metadata {
    name = "${var.persistent_volume_metadata_name}"
  }
  spec {
    capacity = {
      storage = var.persistent_volume_spec_capacity_storage
    }
    access_modes = "${var.persistent_volume_spec_access_modes}"
    persistent_volume_source {
      vsphere_volume {
        volume_path ="${var.persistent_volume_spec_persistent_volume_source_vsphere_volume_volume_path}"
      }
    }
  }
}