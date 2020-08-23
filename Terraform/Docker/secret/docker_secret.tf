# Creates a secret
resource "docker_secret" "foo_secret" {
  name = var.secret_name
  data = var.secret_data
  lifecycle {
    ignore_changes        = ["name"]
    create_before_destroy = true
  }
}


resource "docker_service" "service" {
  # ...
  secrets = [
    {
      secret_id   = "${docker_secret.service_secret.id}"
      secret_name = "${docker_secret.service_secret.name}"
      file_name   = "/root/configs/configs.json"
    },
  ]
}