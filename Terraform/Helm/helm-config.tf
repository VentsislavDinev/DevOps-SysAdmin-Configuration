resource "helm_release" "example" {
  name       = "${var.name}"
  repository = "${var.repository}"
  chart      = "${var.chart}"
  version    = "${var.version}"

  values = var.values

  set {
    name  = "${var.set_name}"
    value = "${var.set_value}"
  }

  set_string {
    name  = "${var.set_string_name}"
    value = "${var.set_string_value}"
  }
}