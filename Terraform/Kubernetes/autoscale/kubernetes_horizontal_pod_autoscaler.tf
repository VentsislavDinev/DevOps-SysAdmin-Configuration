resource "kubernetes_horizontal_pod_autoscaler" "example" {
  metadata {
    name = "${var.horizontal_pod_autoscaler_metadata_name}"
  }

  spec {
    min_replicas = "${var.horizontal_pod_autoscaler_spec_min_replicas}"
    max_replicas = "${var.horizontal_pod_autoscaler_spec_max_replicas}"

    scale_target_ref {
      kind = "${var.horizontal_pod_autoscaler_spec_scale_target_ref_kind}"
      name = "${var.horizontal_pod_autoscaler_spec_scale_target_ref_name}"
    }

    metric {
      type = "${var.horizontal_pod_autoscaler_spec_scale_target_metric_type}"
      external {
        metric {
          name = "${var.horizontal_pod_autoscaler_spec_metric_external_metric_name}"
          selector {
            match_labels = {
              lb_name = var.horizontal_pod_autoscaler_spec_metric_external_metric_selector_match_labels
            }
          }
        }
        target {
          type  = "${var.horizontal_pod_autoscaler_spec_metric_target_type}"
          value = "${var.horizontal_pod_autoscaler_spec_metric_target_value}"
        }
      }
    }
  }
}