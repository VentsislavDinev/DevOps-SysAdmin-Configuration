resource "mysql_user" "jdoe" {
  user               = "${var.user_user}"
  host               = "${var.user_host}"
  plaintext_password = "${var.user_plaintext_password}"
}
