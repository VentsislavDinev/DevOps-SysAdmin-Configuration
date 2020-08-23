resource "grafana_dashboard" "metrics" {
  config_json = "${var.dashboard_config}"
}
