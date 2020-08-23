
resource "rabbitmq_exchange" "test" {
  name  = "${var.name}"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  settings {
    type        = "${var.type}"
    durable     = var.durable
    auto_delete = var.auto_delete
  }
}