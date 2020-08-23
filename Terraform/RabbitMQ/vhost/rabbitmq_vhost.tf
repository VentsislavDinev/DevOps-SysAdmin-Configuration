resource "rabbitmq_vhost" "my_vhost" {
  name = "${var.name}"
}
