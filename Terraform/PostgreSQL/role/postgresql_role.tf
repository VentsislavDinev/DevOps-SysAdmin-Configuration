
resource "postgresql_role" "my_replication_role" {
  name             = "${var.role_name}"
  replication      = var.role_replication
  login            = var.role_logn
  connection_limit = var.role_connection_limit
  password         = "${var.role_password}"
}