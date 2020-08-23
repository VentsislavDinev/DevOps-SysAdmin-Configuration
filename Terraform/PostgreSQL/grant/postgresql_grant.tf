resource "postgresql_grant" "readonly_tables" {
  database    = "${var.grant_database}"
  role        = "${var.grant_role}"
  schema      = "${var.grant_schema}"
  object_type = "${var.grant_object_type}"
  privileges  = var.grant_privileges
}
