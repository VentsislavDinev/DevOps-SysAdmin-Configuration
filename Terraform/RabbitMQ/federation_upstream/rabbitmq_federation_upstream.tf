
// upstream broker
resource "rabbitmq_federation_upstream" "foo" {
  name = "${var.name}"
  vhost = rabbitmq_permissions.guest.vhost

  definition {
    uri = "${var.uri}"
    prefetch_count = var.prefetch_count
    reconnect_delay = var.reconnect_delay
    ack_mode = "${var.ack_mode}"
    trust_user_id = var.trust_user_id
    max_hops = var.max_hops
  }
}