resource "postgresql_extension" "my_extension" {
  name = "${var.extension_name}"
