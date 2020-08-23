resource "influxdb_database" "metrics_aggregation" {
  name = "${var.database_name}"
  retention_policies = var.database_retention_policies 
}