resource "kubernetes_validating_webhook_configuration" "example" {
  metadata {
    name = "${var.validating_webhook_configuration_metadata_name}"
  }

  webhook {
    name = "${var.validating_webhook_configuration_name}"

    admission_review_versions = "${var.validating_webhook_configuration_admission_review_versions}"

    client_config {
      service {
        namespace ="${var.validating_webhook_client_config_namespace}"
        name ="${var.validating_webhook_client_config_name}"
      }
    }

    rule {
      api_groups = "${var.validating_webhook_rule_api_groups}"
      api_versions = "${var.validating_webhook_rule_api_versions}"
      operations = "${var.validating_webhook_rule_operations}"
      resources = "${var.validating_webhook_rule_resources}"
      scope = "${var.validating_webhook_rule_scope}"
    }

    side_effects = "${var.validating_webhook_effects}"
  }
}