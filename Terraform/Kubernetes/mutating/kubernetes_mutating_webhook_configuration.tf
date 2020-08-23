resource "kubernetes_mutating_webhook_configuration" "example" {
  metadata {
    name = "${var.mutating_webhook_configuration_metadata_name}"
  }

  webhook {
    name = "${var.mutating_webhook_configuration_webhook_name}"

    admission_review_versions = "${var.mutating_webhook_configuration_webhook_admission_review_versions}"

    client_config {
      service {
        namespace = "${var.mutating_webhook_configuration_webhook_client_config_service_namespace}"
        name = "${var.mutating_webhook_configuration_webhook_client_config_service_namespace}"
      }
    }

    rule {
      api_groups ="${var.mutating_webhook_configuration_rule_api_groups}"
      api_versions = "${var.mutating_webhook_configuration_rule_api_versions}"
      operations = "${var.mutating_webhook_configuration_rule_operations}"
      resources = "${var.mutating_webhook_configuration_rule_resources}"
      scope = "${var.mutating_webhook_configuration_rule_scope}"
    }

    reinvocation_policy = "${var.mutating_webhook_configuration_reinvocation_policy}"
    side_effects = "${var.mutating_webhook_configuration_side_effects}"
  }
}