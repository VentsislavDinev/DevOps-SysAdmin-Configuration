resource "kubernetes_stateful_set" "prometheus" {
  metadata {
    annotations = {
      SomeAnnotation = var.stateful_set_metadata_anontations_name
    }

    labels = {
      k8s-app                           = var.stateful_set_metadata_labels_name
      "kubernetes.io/cluster-service"   = var.stateful_set_metadata_labels_cluster
      "addonmanager.kubernetes.io/mode" = var.stateful_set_metadata_labels_mode
      version                           = var.stateful_set_metadata_labels_version
    }

    name = "${var.stateful_set_name}"
  }

  spec {
    pod_management_policy  = "${var.stateful_set_pod_management_policy}"
    replicas               = "${var.stateful_set_pod_replicas}"
    revision_history_limit = "${var.stateful_set_pod_revision_history_limit}"

    selector {
      match_labels = {
        k8s-app = var.stateful_set_pod_replicas
      }
    }

    service_name =  "${var.stateful_set_pod_service_name}"

    template {
      metadata {
        labels = {
          k8s-app =  var.stateful_set_pod_app
        }

        annotations = {}
      }

      spec {
        service_account_name =  "${var.stateful_set_pod_spec_service_name}"

        init_container {
          name              =  "${var.stateful_set_pod_spec_service_name}"
          image             =  "${var.stateful_set_pod_spec_service_image}"
          image_pull_policy =  "${var.stateful_set_pod_spec_service_image_pull_policy}"
          command           ="${var.stateful_set_pod_spec_service_command}"

          volume_mount {
            name       = "${var.stateful_set_pod_spec_service_volume_mount_name}"
            mount_path = "${var.stateful_set_pod_spec_service_volume_mount_mount_path}"
            sub_path   = "${var.stateful_set_pod_spec_service_volume_mount_sub_path}"
          }
        }

        container {
          name              = "${var.stateful_set_pod_spec_container_name}"
          image             ="${var.stateful_set_pod_spec_container_image}"
          image_pull_policy = "${var.stateful_set_pod_spec_container_image_pull_policy}"

          args = "${var.stateful_set_pod_spec_container_args}"

          volume_mount {
            name       ="${var.stateful_set_pod_spec_container_volume_mount_name}"
            mount_path = "${var.stateful_set_pod_spec_container_volume_mount_path}"
            read_only  = "${var.stateful_set_pod_spec_container_volume_read_only}"
          }

          resources {
            limits {
              cpu    =  "${var.stateful_set_pod_spec_container_volume_limits_cpu}"
              memory =  "${var.stateful_set_pod_spec_container_volume_limits_memory}"
            }

            requests {
                cpu    =  "${var.stateful_set_pod_spec_container_volume_requests_cpu}"
                memory =  "${var.stateful_set_pod_spec_container_volume_requests_memory}"
            }
          }
        }
/*
        container {
          name              = "prometheus-server"
          image             = "prom/prometheus:v2.2.1"
          image_pull_policy = "IfNotPresent"

          args = [
            "--config.file=/etc/config/prometheus.yml",
            "--storage.tsdb.path=/data",
            "--web.console.libraries=/etc/prometheus/console_libraries",
            "--web.console.templates=/etc/prometheus/consoles",
            "--web.enable-lifecycle",
          ]

          port {
            container_port = 9090
          }

          resources {
            limits {
              cpu    = "200m"
              memory = "1000Mi"
            }

            requests {
              cpu    = "200m"
              memory = "1000Mi"
            }
          }

          volume_mount {
            name       = "config-volume"
            mount_path = "/etc/config"
          }

          readiness_probe {
            http_get {
              path = "/-/ready"
              port = 9090
            }

            initial_delay_seconds = 30
            timeout_seconds       = 30
          }

          liveness_probe {
            http_get {
              path   = "/-/healthy"
              port   = 9090
              scheme = "HTTPS"
            }

            initial_delay_seconds = 30
            timeout_seconds       = 30
          }
        }

        termination_grace_period_seconds = 300

        volume {
          name = "config-volume"

          config_map {
            name = "prometheus-config"
          }
        }
      }
    }
*/
    update_strategy {
      type = "${var.stateful_set_pod_spec_update_strategy_type}"

      rolling_update {
        partition = "${var.stateful_set_pod_spec_update_strategy_partition}"
      }
    }

    volume_claim_template {
      metadata {
        name =  "${var.stateful_set_pod_spec_volume_claim_metadata_name}"
      }

      spec {
        access_modes       = "${var.stateful_set_pod_spec_volume_claim_metadata_access_modes}"
        storage_class_name = "${var.stateful_set_pod_spec_volume_claim_metadata_storage_class_name}"

        resources {
          requests = {
            storage = var.stateful_set_pod_spec_requests_storage
          }
        }
      }
    }
  }
}