resource "dns_txt_record_set" "google" {
  zone = "${var.txt_record_zone}"
  txt = var.txt_record_txt
  ttl = var.txt_record_ttl
}