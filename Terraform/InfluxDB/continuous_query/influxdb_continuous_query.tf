resource "influxdb_continuous_query" "minnie" {
    name = "${var.continuous_query_name}"
    database = "${influxdb_database.test.name}"
    query = "${var.continuous_query_query}"
}