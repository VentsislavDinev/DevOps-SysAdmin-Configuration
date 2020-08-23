resource "dns_ptr_record" "dns-sd" {
  ptr  = "${var.ptr_record_ptr}"
  zone = "${var.ptr_record_zone}"
  name = "${var.ptr_record_name}"
  ttl = var.ptr_record_ttl
}