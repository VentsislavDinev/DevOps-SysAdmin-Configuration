resource "kubernetes_service" "example" {
  metadata {
    name = "${var.service_metadata_name}"
  }
  spec {
    selector = {
      app = kubernetes_pod.example.metadata.0.labels.app
    }
    session_affinity = "${var.service_metadata_session_affinity}"
    port {
      port        =  "${var.service_metadata_port}"
      target_port =  "${var.service_metadata_target_port}"
    }

    type =  "${var.service_metadata_session_type}"
  }
}