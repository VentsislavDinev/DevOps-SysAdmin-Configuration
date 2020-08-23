
resource "postgresql_schema" "my_schema" {
  name  = "${var.schema_name}"
  owner = "${var.schema_owner}"

  # app_releng can create new objects in the schema.  This is the role that
  # migrations are executed as.
  policy {
    create = var.policy_create
    usage  = var.policy_usage
    role   = "${postgresql_role.app_releng.name}"
  }
}