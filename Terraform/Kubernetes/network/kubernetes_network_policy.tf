resource "kubernetes_network_policy" "example" {
  metadata {
    name      = "${var.network_policy_metadata_name}"
    namespace = "${var.network_policy_metadata_namespace}"
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "${var.network_policy_space_pod_selector_match_expressions_key}"
        operator = "${var.network_policy_space_pod_selector_match_expressions_operator}"
        values   = "${var.network_policy_space_pod_selector_match_expressions_values}"
      }
    }

    ingress {
      ports {
        port     = "${var.network_policy_space_ingress_ports_port}"
        protocol = "${var.network_policy_space_ingress_ports_protocol}"
      }
      from {
        namespace_selector {
          match_labels = {
            name =  var.network_policy_space_ingress_from_namespace_selector_match_labels
          }
        }
      }
    }

    egress {} # single empty rule to allow all egress traffic

    policy_types = "${var.network_policy_space_policy_types}"
  }
}