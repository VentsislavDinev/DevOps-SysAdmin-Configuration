resource "dns_ns_record_set" "www" {
  zone = "${var.ns_record_zone}"
  name = "${var.ns_record_name}"
  nameservers = var.ns_record_nameservers
  ttl = var.ns_record_ttl
}