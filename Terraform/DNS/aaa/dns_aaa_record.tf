resource "dns_aaaa_record_set" "www" {
  zone = "${var.record_zone}"
  name = "${var.record_name}"
  addresses = var.record_addresses
  ttl = var.record_ttl
}