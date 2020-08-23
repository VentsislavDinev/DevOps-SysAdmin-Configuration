resource "kubernetes_replication_controller" "example" {
  metadata {
    name = "${var.replication_controller_metadata_name}"
    labels = {
      test =var.replication_controller_metadata_labels_test
    }
  }

  spec {
    selector = {
      test = var.replication_controller_metadata_selecotr_test
    }
    template {
      metadata {
        labels = {
          test =var.replication_controller_template_metadata_labels_test
        }
        annotations = {
          "key1" = "value1"
        }
      }

      spec {
        container {
          image = "${var.replication_controller_container_image}"
          name  = "${var.replication_controller_container_name}"

          liveness_probe {
            http_get {
              path = "${var.replication_controller_http_get_path}"
              port = "${var.replication_controller_http_get_port}"

              http_header {
                name  = "${var.replication_controller_http_header_name}"
                value = "${var.replication_controller_http_header_value}"
              }
            }

            initial_delay_seconds =  "${var.replication_controller_initial_delay_seconds}"
            period_seconds        =  "${var.replication_controller_period_seconds}"
          }

          resources {
            limits {
              cpu    =  "${var.replication_controller_limits_cpu}"
              memory = "${var.replication_controller_limits_memory}"
            }
            requests {
              cpu    =  "${var.replication_controller_requests_cpu}"
              memory =  "${var.replication_controller_requests_memory}"
            }
          }
        }
      }
    }
  }
}