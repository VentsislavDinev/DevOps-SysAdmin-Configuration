resource "postgresql_database" "my_db" {
  name              =  "${ var.database_name}"
  owner             =  "${ var.database_owner}"
  template          =  "${ var.database_template}"
  lc_collate        = "${ var.database_lc_collate}"
  connection_limit  = var.database_connection_limit
  allow_connections = var.database_allow_connections
}
