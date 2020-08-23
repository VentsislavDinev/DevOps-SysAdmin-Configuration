/*
A Deployment ensures that a specified number of pod “replicas” are running at any one time. In other words, a Deployment makes sure that a pod or homogeneous set of pods are always up and available. If there are too many pods, it will kill some. If there are too few, the Deployment will start more.
*/
resource "kubernetes_deployment" "example" {
  metadata {
    name = "${var.deployment_metadata_name}"
    labels = {
      test = var.deployment_metadata_labels_test
    }
  }

  spec {
    replicas = "${var.deployment_spec_replicas}"

    selector {
      match_labels = {
        test = var.deployment_spec_selector_match_labels_test
      }
    }

    template {
      metadata {
        labels = {
          test =  var.deployment_spec_template_metadata_labels_test
        }
      }

      spec {
        container {
          image = "${var.deployment_spec_spec_container_image}"
          name  = "${var.deployment_spec_spec_container_name}"

          resources {
            limits {
              cpu    =  "${var.deployment_spec_spec_container_resource_limits_cpu}"
              memory = "${var.deployment_spec_spec_container_resource_limits_memory}"
            }
            requests {
              cpu    =  "${var.deployment_spec_spec_container_resource_requests_cpu}"
              memory =  "${var.deployment_spec_spec_container_resource_requests_memory}"
            }
          }

          liveness_probe {
            http_get {
              path = "${var.deployment_spec_spec_container_liveness_probe_http_get_path}"
              port = "${var.deployment_spec_spec_container_liveness_probe_http_get_port}"

              http_header {
                name  = "${var.deployment_spec_spec_container_liveness_probe_http_header_name}"
                value = "${var.deployment_spec_spec_container_liveness_probe_http_header_value}"
              }
            }

            initial_delay_seconds =  "${var.deployment_spec_spec_container_initial_delay_seconds}"
            period_seconds        = "${var.deployment_spec_spec_container_period_seconds}"
          }
        }
      }
    }
  }
}