resource "mysql_database" "app" {
  name = "${var.database_name}"
}
