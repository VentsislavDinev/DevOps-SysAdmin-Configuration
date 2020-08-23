resource "kubernetes_api_service" "example" {
  metadata {
    name = var.api_service_metadata_name
  }
  spec {
    selector {
      app = "${kubernetes_pod.example.metadata.0.labels.app}"
    }
    session_affinity = var.api_service_session_affinity
     port {
      port = var.api_service_port_port
      target_port = var.api_service_port_target_port
    }
    type = var.api_service_type
  }
}
 