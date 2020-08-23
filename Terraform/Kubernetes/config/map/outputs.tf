data "kubernetes_config_map" "example" {
  metadata {
    name = "my-config"
  }
}

output "all-ns" {
  value = data.kubernetes_config_map.example.data
}
