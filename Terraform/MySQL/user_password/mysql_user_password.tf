resource "mysql_user_password" "jdoe" {
  user    = "${var.user}"
  pgp_key = "${var.user_pgp}"
}