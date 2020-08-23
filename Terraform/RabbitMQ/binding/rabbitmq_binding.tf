resource "rabbitmq_binding" "test" {
  source           = "${var.soruce}"
  vhost            = "${var.vhost}"
  destination      = "${var.destination}"
  destination_type = "${var.destination_type}"
  routing_key      = "${var.routing_key}"
}