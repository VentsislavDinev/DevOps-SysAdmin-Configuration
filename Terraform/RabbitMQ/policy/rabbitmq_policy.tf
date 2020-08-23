resource "rabbitmq_policy" "test" {
  name  = "${var.name}"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  policy {
    pattern  = "${var.pattern}"
    priority = var.priority
    apply_to = "${var.apply_to}"

    definition = {
      ha-mode = var.ha_mode
    }
  }
}