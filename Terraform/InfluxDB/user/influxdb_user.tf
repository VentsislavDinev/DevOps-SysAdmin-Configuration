resource "influxdb_user" "paul" {
    name = "${var.user_name}"
    password = "${var.user_password}"

    grant {
      database = "${influxdb_database.green.name}"
      privilege = "${var.user_grant_privilege}"
    }
}