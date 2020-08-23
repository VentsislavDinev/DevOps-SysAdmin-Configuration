resource "rabbitmq_queue" "test" {
  name  = "${var.name}"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  settings {
    durable     = var.durable
    auto_delete = var.auto_delete
  }
}