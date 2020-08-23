resource "rabbitmq_shovel" "shovelTest" {
    name = "${var.name}"
    vhost = "${rabbitmq_vhost.test.name}"
    info {
        source_uri = "${var.source_uri}"
        source_exchange = "${rabbitmq_exchange.test.name}"
        source_exchange_key = "${var.source_exchange_key}"
        destination_uri = "${var.destination_uri}"
        destination_queue = "${rabbitmq_queue.test.name}"
    }
}