# Create a new docker network
resource "docker_network" "private_network" {
    name = var.network_name
    labels {
        label = var.network_label
        value = var.network_label_value
    }
    ipam_config {
        subnet = var.network_subnet
        ip_range = var.network_ip_range
        gateway = var.network_range
    }
}