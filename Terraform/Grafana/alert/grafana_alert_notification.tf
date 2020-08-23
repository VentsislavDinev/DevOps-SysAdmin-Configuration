resource "grafana_alert_notification" "email_someteam" {
  name = "${var.alert_notification_email}"
  type = "${var.lert_notification_type}"
  is_default = "${var.lert_notification_is_default}"

  settings {
    "addresses" = var.lert_notification_settings_addresses
    "uploadImage" =  var.lert_notification_settings_uploadImage
  }
}
