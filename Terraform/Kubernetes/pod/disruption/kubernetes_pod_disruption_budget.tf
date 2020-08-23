resource "kubernetes_pod_disruption_budget" "example" {
  metadata {
    name = "${var.pod_disruption_budget_metadata_name}"
  }
  spec {
    max_unavailable            = "${var.pod_disruption_budget_spec_max_unavailable}"
    selector {
      match_labels = {
        test =var.pod_disruption_budget_spec_match_labels_test
      }
    }
  }
}