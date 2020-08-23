resource "rabbitmq_user" "test" {
  name     = "${var.name}"
  password = "${var.password}"
  tags     = var.tags
}
