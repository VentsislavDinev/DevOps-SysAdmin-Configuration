
resource "dns_mx_record_set" "mx" {
  zone = "${var.mx_record_zone}"
  ttl  = var.mx_record_ttl

  mx {
    preference = var.mx_record_preference
    exchange   = "${var.mx_record_exchange}"
  }

  depends_on = var.mx_record_depends_on
}