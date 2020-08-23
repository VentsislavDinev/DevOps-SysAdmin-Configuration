resource "rabbitmq_topic_permissions" "test" {
  user  = "${rabbitmq_user.test.name}"
  vhost = "${rabbitmq_vhost.test.name}"

  permissions {
    exchange = "${var.exchange}"
    write    = "${var.write}"
    read     = "${var.read}"
  }
}