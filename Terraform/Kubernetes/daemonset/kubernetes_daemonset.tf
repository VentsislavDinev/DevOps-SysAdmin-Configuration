/*A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created*/

resource "kubernetes_daemonset" "example" {
  metadata {
    name      = "${var.daemonset_metadata_name}"
    namespace = "${var.daemonset_metadata_namespace}"
    labels = {
      test = var.daemonset_metadata_labels_test}
    }
  }

  spec {
    selector {
      match_labels = {
        test = var.daemonset_spec_selector_match_labels_test
      }
    }

    template {
      metadata {
        labels = {
          test = var.daemonset_template_medatadata_labels_test
        }
      }

      spec {
        container {
          image = "${var.daemonset_spec_container_image}"
          name  = "${var.daemonset_spec_container_name}"

          resources {
            limits {
              cpu    = "${var.daemonset_spec_container_resources_limits_cpu}"
              memory = "${var.daemonset_spec_container_resources_limits_memory}"
            }
            requests {
              cpu    = "${var.daemonset_spec_container_resources_requests_cpu}"
              memory =  "${var.daemonset_spec_container_resources_requests_memory}"
            }
          }

          liveness_probe {
            http_get {
              path =  "${var.daemonset_spec_container_liveness_probe_http_get_path}"
              port = "${var.daemonset_spec_container_liveness_probe_http_get_port}"

              http_header {
                name  = "${var.daemonset_spec_container_http_header_name}"
                value = "${var.daemonset_spec_container_http_header_value}"
              }
            }

            initial_delay_seconds ="${var.daemonset_spec_container_initial_delay_seconds}"
            period_seconds        = "${var.daemonset_spec_container_period_seconds}"
          }
        }
      }
    }
  }
}