resource "postgresql_default_privileges" "read_only_tables" {
  role     =  "${var.role}"
  database = "${var.databse}"
  schema   = "${var.schema}"

  owner       = "${var.owner}"
  object_type = "${var.object_type}"
  privileges  = "${var.privileges}"
}
