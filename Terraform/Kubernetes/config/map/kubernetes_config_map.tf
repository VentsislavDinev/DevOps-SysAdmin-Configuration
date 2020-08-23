resource "kubernetes_config_map" "example" {
  metadata {
    name = "${var.config_map_metadata_name}"
  }

  data = {
    api_host             = var.config_map_data_api_host
    db_host              = var.config_map_data_db_host
    "my_config_file.yml" = var.configur_map_data_my_config_file
  }

  binary_data = {
    "my_payload.bin" = "${var.configur_map_binary_data_my_payload}"
  }
}