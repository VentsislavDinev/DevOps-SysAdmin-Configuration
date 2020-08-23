resource "dns_cname_record" "foo" {
    zone = "${var.record_zone}"
    name = "${var.record_name}"
    cname = "${var.record_cname}"
    ttl = var.record_ttl
}