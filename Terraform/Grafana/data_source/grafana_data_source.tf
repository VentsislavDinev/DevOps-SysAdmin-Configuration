resource "grafana_data_source" "metrics" {
  type          = "${var.data_source_type}"
  name          = "${var.data_source_name}"
  url           = "${var.data_source_url}"
  username      = "${var.data_source_username}"
  password      = "${var.data_source_password}"
  database_name = "${influxdb_database.metrics.name}"

  json_data {
    default_region = "${var.data_source_json_data_default_region}"
    auth_type      = "${var.data_source_json_data_auth_type}"
  }

  secure_json_data {
    access_key = "${var.data_source_secure_json_data_access_key}"
    secret_key = "${var.data_source_secure_json_data_secret_key}"
  }
}
