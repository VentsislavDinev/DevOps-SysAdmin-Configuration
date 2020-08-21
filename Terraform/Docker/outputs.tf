
// get a sample A record report
data "docker_registry_image" "ubuntu" {
   name = "ubuntu:precise"
}

// render sample A record report
output "facebook_address" {
    value = "${join(",", data.docker_registry_image.ubuntu.name)}"
    description = "ubuntu name"
    sensitive   = false
}

