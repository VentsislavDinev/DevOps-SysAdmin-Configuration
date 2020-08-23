resource "mysql_grant" "jdoe" {
  user       = "${var.grant_user}"
  host       = "${var.grant_host}"
  database   = "${var.grant_database}"
  privileges = "${var.grant_privileges}"
}