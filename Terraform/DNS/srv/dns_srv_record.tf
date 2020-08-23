resource "dns_srv_record_set" "sip" {
  zone = "${var.srv_record_zone}"
  name = "${var.srv_record_name}"
  srv {
    priority = var.srv_record_src_priority
    weight   = var.srv_record_src_weight
    target   = "${var.srv_record_src_target}"
    port     = var.srv_record_src_port
  }
  ttl = var_srv_record_ttl
}