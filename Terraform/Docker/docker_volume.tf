# Creates a docker volume "shared_volume".
resource "docker_volume" "shared_volume" {
  name = var.volume_name
  driver = var.volume_driver
}