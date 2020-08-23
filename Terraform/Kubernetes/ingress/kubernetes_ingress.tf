resource "kubernetes_ingress" "example_ingress" {
  metadata {
    name = "${var.ngress_metadata_name}"
  }

  spec {
    backend {
      service_name = "${var.ngress_spec_backend_service_name}"
      service_port =  "${var.ngress_spec_backend_service_port}"
    }

    rule {
      http {
        path {
          backend {
            service_name = "${var.ngress_spec_rule_http_path_backend_service_name}"
            service_port = "${var.ngress_spec_rule_http_path_backend_service_port}"
          }

          path = "${var.ngress_spec_rule_http_path_path}"
        }
      }
    }

    tls {
      secret_name ="${var.ngress_spec_tls_secret_name}"
    }
  }
}