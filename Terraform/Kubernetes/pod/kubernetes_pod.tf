resource "kubernetes_pod" "example" {
  metadata {
    name = "${var.pod_metadata_name}"
  }

spec {
    
    pod_anti_affinity {
        preferred_during_scheduling_ignored_during_execution {
          weight =  "${var.pod_spec_pod_anti_affinity_prefered_during}"

          pod_affinity_term {
            label_selector {
              match_expressions {
                key      = "${var.pod_spec_pod_anti_match_expressions_key}"
                operator = "${var.pod_spec_pod_anti_affinity_prefered_operator}"
                values   ="${var.pod_spec_pod_anti_affinity_prefered_values}"
              }
            }

            topology_key = "${var.pod_spec_pod_anti_affinity_topology_key}"
          }
        }
      }
    }
    affinity {
        node_affinity {
                required_during_scheduling_ignored_during_execution {
                node_selector_term {
                    match_expressions {
                    key      = "${var.pod_spec_pod_node_affinity_key}"
                    operator = "${var.pod_spec_pod_node_affinity_operator}"
                    values   = "${var.pod_spec_pod_node_affinity_values}"
                    }
                }
            }

            preferred_during_scheduling_ignored_during_execution {
                weight = "${var.pod_spec_pod_affinity_preferred_weight}"

                preference {
                    match_expressions {
                        key      = "${var.pod_spec_pod_affinity_key}"
                        operator = "${var.pod_spec_pod_affinity_operator}"
                        values   = "${var.pod_spec_pod_affinity_values}"
                    }
                }
            }
        }
        }
    }
    container {
      image = "${var.pod_spec_container_image}"
      name  = "${var.pod_spec_container_name}"

      env {
        name  = "${var.pod_spec_container_env_name}"
        value = "${var.pod_spec_container_env_name}"
      }

      port {
        container_port ="${var.pod_spec_container_port_container_port}"
      }

      liveness_probe {
        http_get {
          path = "${var.pod_spec_container_http_get_path}"
          port = "${var.pod_spec_container_http_get_port}"

          http_header {
            name  ="${var.pod_spec_container_http_header_name}"
            value ="${var.pod_spec_container_http_header_value}"
          }
        }

        initial_delay_seconds = "${var.pod_spec_container_initial_delay_seconds}"
        period_seconds        = "${var.pod_spec_container_period_seconds}"
      }
    }

    dns_config {
      nameservers ="${var.pod_spec_container_dns_config_nameservers}"
      searches    ="${var.pod_spec_container_dns_config_searches}"

      option {
        name  = "${var.pod_spec_container_dns_config_option_name}"
        value = "${var.pod_spec_container_dns_config_option_value}"
      }
    }

    dns_policy = "${var.pod_spec_container_dns_policy}"
  }
}