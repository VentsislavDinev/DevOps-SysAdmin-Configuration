resource "rabbitmq_permissions" "test" {
  user  = "${rabbitmq_user.test.name}"
  vhost = "${rabbitmq_vhost.test.name}"

  permissions {
    configure = "${var.configure}"
    write     = "${var.write}"
    read      = "${var.read}"
  }
}