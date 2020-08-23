# Create a Grafana organization with defined membership, creating placeholder
# accounts for users that don't exist.
resource "grafana_organization" "test-org" {
    name         = "${var.organization_name}"
    admin_user   = "${var.organization_admin_user}"
    create_users = var.organization_create_users
    admins       = var.organization_admins
    editors      = var.organization_editors
    viewers      = var.organization_viewers
}
